# 🛠️ Migrador de Repositórios Locais para GitHub

Este script Bash automatiza a migração de múltiplos repositórios Git locais (presentes como subpastas) para sua conta GitHub, utilizando a GitHub CLI (`gh`). Cada subpasta representa um repositório Git a ser migrado.

---

## ✅ Funcionalidades

- Detecta automaticamente os repositórios locais em subpastas.
- Verifica se o repositório já existe no GitHub:
  - Se não existir, cria um novo.
  - Se já existir, usa o existente.
- Tenta manter o histórico completo do Git.
- Caso a tentativa de push com histórico falhe, reinicializa o repositório e faz um commit limpo.
- Configura a branch padrão como `main`.
- Push automático para o GitHub.

---

## 🔧 Pré-requisitos

- **Git instalado:** `git --version`
- **GitHub CLI (`gh`) instalado e autenticado:**
```bash
  gh auth login
````

* **`jq` instalado:** usado para processar JSON retornado pelo `gh`

---

## 🚀 Como usar

1. **Clone ou copie o script** para um arquivo, por exemplo:

   ```bash
   chmod +x migrate_repos.sh
   ```

2. **Coloque o script dentro do diretório que contém os repositórios como subpastas.**

3. **Execute o script:**

   ```bash
   ./migrate_repos.sh
   ```

---

## 📁 Estrutura esperada

```
meus-repositorios/
├── repo1/
│   └── .git/
├── repo2/
│   └── .git/
└── migrate_repos.sh
```

Cada subpasta deve ser um repositório Git válido (conter `.git/`).

---

## 📝 Licença

Este projeto é de uso livre, sem garantia explícita. Use por sua conta e risco.

---

## 🙋‍♂️ Suporte

Se você encontrar algum problema ou desejar sugerir melhorias, abra uma *issue* ou envie um *pull request*.

```

---