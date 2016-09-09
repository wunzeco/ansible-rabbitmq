rabbitmq
=======

Ansible role to install and configure RabbitMQ.


## Example

```
- hosts: myhost

  vars:
    rabbitmq_version: 3.6.5-1
    rabbitmq_plugins_enable: [ rabbitmq_management ]
    rabbitmq_vhosts_add: [ '/test', '/svc' ]
    rabbitmq_users_add:
      - user: ogonna
        password: ogonnaPass
        permissions:
          - { vhost: /test, read_priv: '.*', write_priv: '.*', configure_priv: '.*' }
          - { vhost: /svc, read_priv: '.*', write_priv: '.*', configure_priv: '^$' }
    
  roles:
    - wunzeco.rabbitmq
```


## Testing

To run this role's integration tests

```
kitchen test
```


## Dependencies

none
