# 🗺️ App_BuscarCEP

Aplicativo buscar CEP desenvolvido em Flutter, consumindo a API ViaCep e salvando os dados no banco de dados Objectbox.

## Para executar o migrations

Para mais informações sobre o migrations acesse [objectbox](https://docs.objectbox.io/getting-started).
A migração dos dados podem ser realizadas com os comandos abaixos:

```bash
  dart run build_runner build
  flutter packages pub run build_runner build
```

## Funcionalidades

- Criar novos cep´s de acordo com o que está vindo da API
- Filtro para buscar através de um determinado CEP
- Excluir os dados de um determinado CEP do Banco de Dados
- Abrir Google Maps passando o CEP salvo no banco de dados como parâmetro.
- Tema Escuro ou Claro. O aplicativo pega o tema de acordo com o que está determinado no sistema do aparelho.

## Temas Implementados

<div style="display: inline_block">
  <img align="center" alt="tema-dark" height="450" src="https://raw.githubusercontent.com/Kawan02/App_BuscaCEP/dev-ksm-att-packages/application_busca_cep/assets/imgs/Dark/dark.PNG">
  <img align="center" alt="tema-dark" height="450" src="https://raw.githubusercontent.com/Kawan02/App_BuscaCEP/dev-ksm-att-packages/application_busca_cep/assets/imgs/Dark/filter.PNG">
  <img align="center" alt="tema-dark" height="450" src="https://raw.githubusercontent.com/Kawan02/App_BuscaCEP/dev-ksm-att-packages/application_busca_cep/assets/imgs/Dark/filter_dark.PNG">
</div>

<br/>

<div style="display: inline_block">
<img align="center" alt="tema-white" height="450" src="https://raw.githubusercontent.com/Kawan02/App_BuscaCEP/dev-ksm-att-packages/application_busca_cep/assets/imgs/White/white.PNG">
  <img align="center" alt="tema-white" height="450" src="https://raw.githubusercontent.com/Kawan02/App_BuscaCEP/dev-ksm-att-packages/application_busca_cep/assets/imgs/White/filter.PNG">
  <img align="center" alt="tema-white" height="450" src="https://raw.githubusercontent.com/Kawan02/App_BuscaCEP/dev-ksm-att-packages/application_busca_cep/assets/imgs/White/filter_white.PNG">
</div>
