import subprocess
import sys



def hc(*argument_list):
    """ Executes 'herbstclient' with the arguments given separated by space """
    argument_str = ""
    for arg in argument_list:
        argument_str += f"{arg} "

    output = None
    return_code = 0
    try:
        output = subprocess.check_output("herbstclient " + argument_str, shell=True)
    except subprocess.CalledProcessError as error:
        return_code = error.returncode
        print(f"HC Error -- CMD: {error.cmd}\n\tRET: {return_code}", file=sys.stderr)
    return output, return_code 
        

def hc_hook_handler(hook_name):
    return subprocess.Popen(["herbstclient", "--idle", hook_name], stdout=subprocess.PIPE)
