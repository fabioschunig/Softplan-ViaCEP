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
- Na tela do cliente pode-se escolher se a consulta será feita via JSON ou XML
- O usuário tem a opção de consultar pelo CEP:

![Consulta CEP](/img/pesquisa-cep.png "Consulta de CEP")

- Também pode consultar usando dados de endereços:

![Consulta Endereço](/img/pesquisa-endereco.png "Consulta de endereços")

- Os resultados são formatados e apresentam a data da consulta
- O usuário pode escolher repetir a consulta, atualizando os dados quando já estiverem armazenados na base de dados

<br>

## Arquitetura de desenvolvimento

### Onion Architecture e DDD
- Utilizada [Onion Architecture](https://vitormoschetti.medium.com/onion-architecture-defini%C3%A7%C3%A3o-camadas-e-benef%C3%ADcios-551f460c3b2c) para separar o desenvolvimento das classes
- Utilizado práticas de [DDD](https://en.wikipedia.org/wiki/Domain-driven_design) (Domain-Driven Design), separando entre classes de domínio, aplicação e infraestrutura
    - 1 [Domínio] (Servidor/src/Domain)
    - 2 [Aplicação] (Servidor/src/Application)
    - 3 [Infrastrutura] (Servidor/src/Infra)
- Dessa forma, caso seja necessário alterar alguma tecnologia (Indy, por exemplo), terá impacto apenas na camada de Infra

### Clean Code
- Utilizado técnicas de Clean Code na maior parte do código

### SOLID e Design Patterns
- Utilizado práticas de SOLID nas classes do Servidor e do componente
- Utilizada injeção de dependência
- Utilizados padrões de projeto como Builder e Template Method

### POO
- Código fonte altamento focado em POO, fazendo conversão dos resultados e hidratação para instâncias das classes

### JSON e XML
- Criadas classes para fazer a conversão dos resultados de JSON e XML para modelos do domínio do sistema

### Interfaces
- Estrutura de classes do Servidor focada em interfaces

### Criação de Componentes
- Criado um componente específico para consulta ao site ViaCEP na package `dclBuscaEnderecoCEP`

<br>
