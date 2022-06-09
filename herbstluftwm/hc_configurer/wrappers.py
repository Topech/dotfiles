import os



def hc(*argument_list):
    """ Executes 'herbstclient' with the arguments given separated by space """
    argument_str = ""
    for arg in argument_list:
        argument_str += f"{arg} "
    return os.system("herbstclient " + argument_str)



if __name__ == "__main__":
    hc("reload")
