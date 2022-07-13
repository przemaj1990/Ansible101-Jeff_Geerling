# ansible custome plugin

def is_red(string):
    red_value = ['red']
    if string in red_value:
        return True
    else:
        return False

class TestModule(object):
    ''' Ansible red test'''

    def tests(self):
        return {
            'red': is_red
        }

