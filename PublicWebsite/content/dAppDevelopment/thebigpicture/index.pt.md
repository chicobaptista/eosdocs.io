---
título: "O quadro geral"
date: 2018-04-24T09:27:15-04:00
weight: 1
draft: false
---

#### Sumário

O stack do software EOS possui várias ferramentas. Muitos dos tutoriais que vimos explicam como executar tudo em uma única máquina. Isso pode ser confuso porque o leitor tende a perder de vista como tudo se encaixa. 

A imagem abaixo mostra como essas ferramentas são normalmente distribuídas. Os nomes das ferramentas são escritos em letras **VERMELHAS E GRANDES** nas imagens. Aqui está um resumo rápido:

* ** eosiocpp ** - Um compilador que permite compilar seu C ++ em um formato que pode ser enviado para a blockchain. 
* ** cleos ** - Uma ferramenta de linha de comando usada para enviar seus contratos para a blockchain e consultar a blockchain. 
* ** keosd ** - Um gerenciador de carteira que é executado como um daemon. A ferramenta cleos interage com isso para assinar solicitações (necessárias para que suas solicitações à blockchain possam ser confiáveis). 
* ** nodeos ** - O software do servidor que executa a blockchain em si.

{{% notice warning %}}
Ao percorrer o restante deste site, consideramos que você está executando o ** nodeos ** em uma máquina/servidor e usando o restante das ferramentas de outra máquina. Embora isso pareça inconveniente no início, tornará alguns conceitos muito mais claros. 
{{% /notice %}}

![quadro Geral] (images/BigPicture.jpeg)


