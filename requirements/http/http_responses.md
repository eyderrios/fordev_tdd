# HTTP

> ## Sucesso
1. ✅ Request com verbo HTTP válido (post)
2. ✅ Passar nos headers o content type JSON
3. ✅ Chamar request com body correto
4. ✅ Ok - 200 e resposta com dados
5. ✅ No content - 204 e resposta sem dados

> ## Erros
1. ✅ Bad request (400)
2. ✅ Unauthorized (401)
3. ✅ Forbidden (403)
4. ✅ Not found (404)
5. ✅ Internal server error (500)

## Exceção - Status code diferente dos listados acima
1. ✅ Internal server error (500)

## Exceção - HTTP request levantou alguma exceção
1. Internal server error (500)

## Exceção - Verbo HTTP inválido
1. Internal server error (500)
