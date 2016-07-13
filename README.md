rabbitmq
=======

Ansible role to install and configure RabbitMQ.


## Example

```
- hosts: myhost

  vars:
    rabbitmq_version: 3.6.3-1
    
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
