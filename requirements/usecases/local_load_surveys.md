# Local Load Surveys

> ## Caso de sucesso
1. Sistema solicita os dados das enquetes do Cache
2. Sistema entrega os dados das enquetes
> ## Exceção - Cache vazio
1. Sistema retorna uma mensagem de erro inesperado

---

# Local Validate Surveys

> ## Caso de sucesso
1. Sistema solicita os dados das enquetes do Cache
> ## Exceção - Dados inválidos no cache
1. Sistema limpa os dados do cache

---

# Local Save Surveys

> ## Caso de sucesso
1. Sistema valida dos dados das enquetes
2. Sistema apaga dos dados do cache antigo
3. Sistema grava os novos dados no Cache

> ## Exceção - Erro ao apagar dados no Cache
1. Sistema retorna uma mensagem de erro

> ## Exceção - Erro ao gravar dados no Cache
1. Sistema retorna uma mensagem de erro
