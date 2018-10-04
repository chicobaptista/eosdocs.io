---
title: "Desenvolvimento Web"
date: 2018-04-30T15:53:46-04:00
draft: false
weight: 7
---

### Esta seção ainda está em construção

Atualmente, a melhor maneira de interagir com o EOS blockchain a partir de um navegador da Web é usar a biblioteca Javascript [EOSJS](https://github.com/EOSIO/eosjs). O README também possui vários exemplos.

{{% notice warning %}}
Observe que, se você for um desenvolvedor do Windows, o comando "npm run build_browser" falhará. Para contornar isso, execute "browserify -o dist/eos.js -s Eos lib/index.js" .. isso irá gerar o arquivo eos.js na pasta dist (você precisará ter browserify instalado, é claro - "npm install -g browserify "). 
{{% /notice %}}