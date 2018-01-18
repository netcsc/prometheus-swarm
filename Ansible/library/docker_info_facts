#!/usr/bin/env python
from ansible.module_utils.basic import *

docker_lib_missing=False

try:
    from docker import Client
except:
    try:
        from docker import APIClient as Client
    except:
        docker_lib_missing=True

def _get_docker_info():
    try:
        return Client().info(), False
    except Exception as e:
        return {}, e.message

def main():
    module = AnsibleModule(
        argument_spec=dict(),
        supports_check_mode=False
    )

    if docker_lib_missing:
        msg = "Could not load docker python library; please install docker-py or docker library"
        module.fail_json(msg=msg)

    info, err = _get_docker_info()

    if err:
        module.fail_json(msg=err)

    module.exit_json(
        changed=True,
        ansible_facts={'docker_info': info})

if __name__ == '__main__':
    main()