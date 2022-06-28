# Feature: Login
COMO    um cliente
QUERO   poder acessar minha conta e me manter logado
PARA    que eu possa ver e responder enquetes de forma rápida

# Cenário: Credenciais válidas
DADO    que o cliente informou credenciais válidas
QUANDO  solicitar fazer login
ENTÃO   o sistema deve enviar o usuário para a tela de pesquisas
E       manter o usuário conectado

# Cenário: Credenciais inválidas
DADO    que o cliente informou credenciais inválidas
QUANDO  solicitar fazer login
ENTÃO   o sistema deve retornar uma mensagem de erro
