{% set image_repo = salt['pillar.get']('demo_app:image:repo') %}
{% set image_tag = salt['pillar.get']('demo_app:image:tag') %}
{% set image_ref = image_repo ~ ':' ~ image_tag %}

app_prerequisites:
  pkg.installed:
    - pkgs:
      - podman

demo_app_systemd_unit:
  file.managed:
    - name: /etc/systemd/system/demo-app.service
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        [Unit]
        Description=Demo app container (Podman)
        After=network-online.target
        Wants=network-online.target

        [Service]
        Type=simple
        Restart=always
        RestartSec=5
        ExecStartPre=/usr/bin/podman pull {{ image_ref }}
        ExecStartPre=-/usr/bin/podman rm -f demo-app
        ExecStart=/usr/bin/podman run --rm --name demo-app --replace -p 80:80 {{ image_ref }}
        ExecStop=/usr/bin/podman stop -t 10 demo-app

        [Install]
        WantedBy=multi-user.target
    - require:
      - pkg: app_prerequisites

demo_app_systemd_reload:
  module.run:
    - service.systemctl_reload:
    - onchanges:
      - file: demo_app_systemd_unit

demo_app_service:
  service.running:
    - name: demo-app
    - enable: True
    - require:
      - pkg: app_prerequisites
      - file: demo_app_systemd_unit
      - module: demo_app_systemd_reload
    - watch:
      - file: demo_app_systemd_unit

