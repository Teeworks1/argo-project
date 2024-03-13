{{- define "webappImage" }}
- name: {{ .Values.app}}
  image: {{ .Values.app}}:latest
  ports:
  - containerPort: 80
    name: {{ .Values.name}}
{{- end }}