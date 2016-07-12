rabbitmq_service:
  service.running:
    - name: rabbitmq-server
    - enable: True
    - watch:
      - sls: rabbitmq.install
