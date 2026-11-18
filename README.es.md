# AI Engineering Playbook

Cómo construyo software con agentes de código sin renunciar a la disciplina de ingeniería.

No es una colección de prompts. Es el sistema operativo alrededor del agente: un contrato, un plan con gates, tests como red de seguridad, revisión humana del diff y una rutina de higiene de secretos que asume que el agente acabará cometiendo un error.

[English](README.md) · [Português](README.pt.md) · [日本語](README.ja.md)

---

## El problema

Los agentes de código son rápidos y seguros de sí mismos. Esa combinación es peligrosa cuando la tarea toca producción, datos personales, credenciales o código de clientes.

Los fallos para los que diseño:

- el agente dice que un test pasó cuando solo arrancó la app;
- un plan cambia de alcance a mitad de implementación;
- un secreto acaba en un commit, un fixture o una captura;
- un "refactor pequeño" reescribe una interfaz pública;
- el diff es demasiado grande para revisarlo, así que nadie lo revisa;
- se pierde el contexto y la siguiente sesión repite los mismos errores.

## El método

### 1. Un contrato: `AGENTS.md`

El repositorio tiene un contrato escrito para agentes: misión, fuente de verdad, invariantes, acciones prohibidas, requisitos de verificación y definición de terminado. Es corto para leer y concreto para exigir.

Plantilla: [`templates/AGENTS.md`](templates/AGENTS.md)

### 2. Un plan con gates

El trabajo se divide en fases. Cada fase tiene objetivo, informe, evidencia y gate. Si una fase no puede cumplir su gate, se para y pregunta; no improvisa.

Plantilla: [`docs/PLAN-TEMPLATE.md`](docs/PLAN-TEMPLATE.md)

### 3. Tests como red

Un test que solo arranca la app no es un test superado. Debe importar, editar, guardar, reabrir y renderizar cuando el producto hace eso. Las comprobaciones que dependen de hardware se marcan y se saltan solo si el hardware falta de verdad.

Guía: [`docs/TESTING-WITH-AGENTS.md`](docs/TESTING-WITH-AGENTS.md)

### 4. Revisión humana del diff

El agente propone; la persona acepta. La revisión busca scope creep, cambios silenciosos de interfaz, tests eliminados, dependencias nuevas, secretos, PII y documentación engañosa.

Checklist: [`docs/REVIEW-CHECKLIST.md`](docs/REVIEW-CHECKLIST.md)

### 5. Higiene de secretos

Asume que un secreto acabará pegado en algún sitio. Diseña para que no llegue al repositorio:

- escanea archivos rastreados, no solo el working tree;
- escanea archivos ocultos y rastreados pero ignorados;
- fija una identidad de commit pública;
- usa historia Git nueva para releases públicos;
- ejecuta un check pre-push que falle cerrado;
- rota cualquier cosa que haya estado expuesta.

Guía: [`docs/SECRET-HYGIENE.md`](docs/SECRET-HYGIENE.md)  
Script: [`scripts/check-no-secrets.sh`](scripts/check-no-secrets.sh)

### 6. MCP y herramientas locales

Los servidores MCP son potentes y fáciles de sobre-permitir. Ata a localhost, limita tokens, registra llamadas y no pongas un token en un config que se pueda commitear.

Guía: [`docs/MCP-SETUP.md`](docs/MCP-SETUP.md)

---

## Qué hay en este repositorio

```text
templates/AGENTS.md          plantilla de contrato para un repositorio
docs/PLAN-TEMPLATE.md        plan por fases con gates y evidencia
docs/REVIEW-CHECKLIST.md     checklist de revisión humana
docs/TESTING-WITH-AGENTS.md  estrategia de tests para código escrito por agentes
docs/MCP-SETUP.md            configuración local de MCP y permisos
docs/SECRET-HYGIENE.md       escaneo, identidad de commit, respuesta a incidentes
scripts/check-no-secrets.sh  escáner pequeño sin dependencias
```

## Qué no es

- No es una lista de prompts mágicos.
- No afirma que los agentes sustituyan la revisión.
- No garantiza que un escaneo encuentre todos los secretos.
- No está atado a un proveedor; los ejemplos usan herramientas genéricas.

## Para quién es

Para ingenieros que usan agentes de código en repositorios reales, sobre todo cuando el trabajo toca producción, datos personales o código de clientes.

## Licencia

CC BY 4.0. Ver [`LICENSE`](LICENSE).
