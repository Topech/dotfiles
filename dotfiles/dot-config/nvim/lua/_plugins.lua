vim.cmd [[
    call plug#begin()
        Plug 'nvim-lua/plenary.nvim'
	    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
	    Plug 'ThePrimeagen/harpoon'
	    Plug 'tpope/vim-surround'
	    Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main'}
	    Plug 'mason-org/mason.nvim'
  call plug#end()
]]


vim.filetype.add({
    pattern = {
        ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
        ["compose.*%.ya?ml"] = "yaml.docker-compose",
    }
})


local function _config_mason_lsps(mason_lsps)
    local mason_ok, mason = pcall(require, "mason")
    local mason_reg_ok, mason_reg = pcall(require, "mason-registry")
    if not mason_ok or not mason_reg_ok then
        vim.notify("Mason isn't available yet. Install it and restart neovim")
        return
    end
    mason.setup()

    local missing = {}

    for _, server in ipairs(mason_lsps) do
      if not mason_reg.is_installed(server) then
        table.insert(missing, server)
      end
    end

    if #missing > 0
      and vim.fn.confirm("Install missing servers: " .. table.concat(missing, ", ") .. "?", "&Yes\n&No", 2) == 1
    then
      vim.cmd("MasonInstall " .. table.concat(missing, " "))
    end
end



local function _config_lsps()

    local default_root_markers = { '.venv', '.git' }
    vim.lsp.config('*', {
        root_markers = default_root_markers,
    })


    vim.lsp.config("uv-ruff", {
        cmd = { 'uv', 'run', 'ruff', 'server' },
        filetypes = { 'python' },
        root_markers = vim.list_extend({"pyproject.toml", "uv.lock"}, default_root_markers),
        settings = {
            python = {
                analysis = {
                    -- required for go to defs/refs/decl etc.
                    diagnosticMode = "workspace",
                },
            },
        }
    })
    vim.lsp.enable("uv-ruff")

    vim.lsp.config("uv-pyright", {
        cmd = { 'uv', 'run', 'pyright-langserver', "--stdio" },
        filetypes = { 'python' },
        root_markers = vim.list_extend({"pyproject.toml", "uv.lock"}, default_root_markers),
        settings = {
            python = {
                analysis = {
                    -- required for go to defs/refs/decl etc.
                    diagnosticMode = "workspace",
                },
            },
        }
    })
    vim.lsp.enable("uv-pyright")


    vim.lsp.config("mason-lua-ls", {
        cmd = { "lua-language-server" },
        filetypes = { 'lua' },
        root_markers = vim.list_extend({"init.vim"}, default_root_markers),
	settings = {
	    Lua = {
	        diagnostics = { globals = { "vim" }, },
		workspace = {
		    library = vim.api.nvim_get_runtime_file('', true),  -- load nvim runtime files for better autocompletion
	        },
	    }
	}
    })
    vim.lsp.enable("mason-lua-ls")


    vim.lsp.config("mason-docker-ls", {
        cmd = { "docker-language-server", "start", "--stdio" },
        filetypes = { "dockerfile", "yaml.docker-compose" },
        get_language_id = function(_, filetype)
            if filetype == "yaml.docker-compose" then
                return "dockercompose"
            end
            return filetype
        end,
        root_markers = vim.list_extend({"compose.yaml", "compose.yml", "docker-compose.yaml", "docker-compose.yml"}, default_root_markers),
    })
    vim.lsp.enable("mason-docker-ls")


    vim.lsp.config("mason-nix-nil", {
        cmd = { "nil" },
        filetypes = { "nix" },
        root_markers = vim.list_extend({"flake.nix"}, default_root_markers),
    })
    vim.lsp.enable("mason-nix-nil")


    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, client.id, ev.buf, {
            autotrigger = false,
          })
	  vim.keymap.set(
	    'i',
	    '<C-Space>',
	    function() vim.lsp.completion.get() end,
	    { desc = "Trigger LSP Completion" }
	  )
        end
      end,
    })

end

local function _config_treesitter()
    local treesitter = require('nvim-treesitter')
    local treesitter_langs = {
    	'python',
    	'lua',
    	'vim',
    	'bash',
        'javascript',
        'typescript',
        'html',
        'css',
        'nix',
        'toml',
        'json',
        'yaml',
    }
    treesitter.setup()
    treesitter.install(treesitter_langs)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = treesitter_langs,
      callback = function()
        vim.treesitter.start()
      end,
    })

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.foldlevel = 99 -- leave folds open initially
end


local function _config_telescope()
    local telescope = require("telescope")
    telescope.setup( { defaults = { preview = { treesitter = false } } } )
end


vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local missing = false

    for _, plugin in pairs(vim.g.plugs or {}) do
      if vim.fn.isdirectory(plugin.dir) == 0 then
        missing = true
        break
      end
    end

    if missing and vim.fn.confirm("Install missing plugins?", "&Yes\n&No", 2) == 1 then
      vim.cmd("PlugInstall --sync")
      vim.notify("Plugins installed, Restart Neovim to load them")
    end

    if not missing then
        local mason_lsps = { "lua-language-server", "docker-language-server", "nil" }
        _config_mason_lsps(mason_lsps)
	_config_lsps()
	_config_treesitter()
    _config_telescope()
    vim.cmd("let g:surround_no_mappings = 1")

	require("telescope").load_extension("harpoon")

    end
  end,
})

