# Softplan-ViaCEP
Softplan - Consulta de endereços e CEP

<br>

## Informações sobre o projeto Delphi
- Desenvolvido usando a versão 12.1 Athens
- Comunicação entre Cliente e Servidor utilizando DataSnap
- Compilação de 32 bits

## Instalação da package BuscaEnderecoCEP
- Abrir o projeto `dclBuscaEnderecoCEP`
- Compilar e instalar
- Adicionar ao Library Path o caminho até o diretório `(...)\Package BuscaEnderecoCEP\src`

## Testes unitários da package
- Com a package dclBuscaEnderecoCEP instalada e configurada, abrir o projeto `testBuscaEnderecoCEP`
- Compilar o projeto
- Abrir uma janela de terminal e navegar até o diretório do executável
- Rodar os testes com o comando:

> testBuscaEnderecoCEP.exe

## Configuração do ambiente para testes
- Arquivos DLL do diretório `dlls` devem ser copiados junto ao `Servidor` ou no diretório do sistema (Por exemplo: `C:\Windows\`)
- Por comodidade, foi utilizada uma base de dados `SQLite`, que é criada automaticamente ao subir o `Servidor`
- Abrir o executável `Servidor`
- Abrir o executável `Cliente`
- Na tela pode-se escolher se a consulta será feita via JSON ou XML
- O usuário tem a opção de consultar pelo CEP:

![Consulta CEP](/img/pesquisa-cep.png "Consulta de CEP")

- Também pode consultar usando dados de endereços:

![Consulta Endereço](/img/pesquisa-endereco.png "Consulta de endereços")

- Os resultados são formatados e apresentam a data da consulta
- O usuário pode escolher repetir a consulta atualizando os dados quando já existir na base de dados
