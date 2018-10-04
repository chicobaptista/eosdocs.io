---
title: "Obtendo o software"
date: 2018-04-24T09:21:04-04:00
weight: 2
draft: false
---

Existem vários métodos disponíveis para obter o software. 

* [Instâncias da Amazon AWS](amazonaws) - Use uma Amazon Machine Image (AMI) fornecida pela EOSDocs.io - se você for familiarizado com a AWS, essa é de longe a maneira mais rápida de começar. 

* [Docker](docker) - Use a imagem docker fornecida pelo EOS para compilar. Essa é uma excelente opção se você estiver familiarizado com o docker. Note que os nodeos e keosd são ambos servidores que se ligam à porta 8888 por padrão. Mesmo se você estiver usando o docker, ainda sugerimos que você execute o nodeos em uma máquina diferente enquanto segue esses tutoriais.

* [Compilar](compile) - Compile diretamente o código fonte. Este é o método mais complexo. 


{{% notice warning %}}
Como mencionado em [O quadro geral] (../bigbicture) sugerimos a execução do nodeos em uma máquina separada. É possível executar todo o software em uma única máquina, mas a separação do software facilita o aprendizado. 
{{% /notice %}}
