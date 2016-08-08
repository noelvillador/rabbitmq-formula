{% from 'rabbitmq/map.jinja' import rabbitmq with context %}

rabbitmq_service:
  service.running:
    - name: rabbitmq-server
    - enable: True
    - watch:
      - sls: rabbitmq.install
      - file: /etc/rabbitmq/rabbitmq.config

/etc/rabbitmq:
  file.directory

/etc/rabbitmq/rabbitmq.config:
  file.managed:
    - template: jinja
    - source: salt://rabbitmq/templates/rabbitmq.config
    - require:
      - file: /etc/rabbitmq

{% if rabbitmq.cluster_hosts %}
dead-rabbitmq-server:
  service.dead:
    - name: rabbitmq-server

/var/lib/rabbitmq/.erlang.cookie:
  file.managed:
    - user: rabbitmq
    - group: rabbitmq
    - mode: 400
    - source: salt://rabbitmq/templates/erlang.cookie
    - template: jinja
    - prereq_in:
      # we have to stop rabbit before we change this cookie
      - service: dead-rabbitmq-server
    - watch_in:
      - service: rabbitmq-server
{% endif %}
