{{- define "webappImage" }}
- name: {{ .Values.app}}
  image: {{ .Values.app}}:1.14.2
  ports:
  - containerPort: 80
    name: {{ .Values.name}}
{{- end }}