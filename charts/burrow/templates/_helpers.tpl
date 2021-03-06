{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "burrow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "burrow.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "burrow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "burrow.labels" -}}
app.kubernetes.io/name: {{ include "burrow.name" . }}
helm.sh/chart: {{ include "burrow.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
  Servers formatting
*/}}
{{- define "burrow.config.zookeeper.servers" -}}
{{- $first := true -}}
[
{{- range $server := .Values.burrow.config.zookeeper.servers -}}
{{- if $first -}}
    {{- $first = false -}}
{{- else -}}
    ,
{{- end -}}
{{ ($server | quote) -}}
{{- end -}}
]
{{- end -}}


{{/*
  Burrow server list formatting
*/}}
{{- define "burrow.servers" -}}
{{- $first := true -}}
[
{{- range $server := . -}}
{{- if $first -}}
    {{- $first = false -}}
{{- else -}}
    ,
{{- end -}}
{{ ($server | quote) -}}
{{- end -}}
]
{{- end -}}
