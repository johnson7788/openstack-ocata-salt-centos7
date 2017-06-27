include:
  - rabbitmq.install

rabbitmq-env:
  file.managed:
    - name: /tmp/rabbitmq.sh
    - source: salt://rabbitmq/files/rabbitmq.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      RABBIT_PASS: {{ pillar['password']['RABBIT_PASS'] }}
  cmd.run:
    - name: /usr/bin/sh /tmp/rabbitmq.sh && touch /etc/rabbitmq/rabbitmq.lock
    - unless: test -f /etc/rabbitmq/rabbitmq.lock
