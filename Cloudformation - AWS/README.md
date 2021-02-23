# Cloudformation AWS

Demonstração de IAC no ambiente AWS.

## Requisitos

- [Instalar o AWS Command Line Interface](https://docs.aws.amazon.com/cli/pt_br/latest/userguide/install-cliv2.html);
- [Configurar o AWS CLI](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-chap-configure.html)

## Passo a passo

### Validação

Em alguns casos, é interessante ter um passo de validação do template do CloudFormation, assim já se obtem detalhes de possíveis falhas antes de publicar sua infraestrutura, 
tal validação é feita através do seguinte comando:

* `aws cloudformation validate-template --template-body file://template.yaml`

### Publicação

A publicação ou *deploy* do seu template, é o passo que efetivamente a infraestrutura que você definiu será aplicada na sua conta AWS, para fazer a publicação basta executar o seguinte comando:

* `aws cloudformation deploy --template-file template.yaml --stack-name live-gft-iac-aws --s3-bucket cf-templates-live-gft`

Observação: Para realizar o teste corretamente em sua conta, é necessário que exista um bucket em sua conta para o upload do template do CloudFormation, que no exemplo de comando está definido como `cf-templates-live-gft`.

### Conteúdo do site

O upload dos artefatos que compõe o site é feito em uma etapa separada da infraestrutura, isso porque o CloudFormation não suporta essa operação neste cenário, para isso precisamos executar o seguinte comando:

* `aws s3 cp site s3://live-gft-iac/ --recursive --acl 'public-read'`

### Remoção

Para remover a infraestrutura que foi provisionada na AWS, é necessário executar o seguinte comando:

* `aws cloudformation delete-stack --stack-name live-gft-iac-aws`

Para remoção completa dos recursos, precisamos apagar o conteúdo do bucket para depois deletar o bucket, pois esse conteúdo foi adicionado após a criação da infraestrutura, para isso basta rodar os seguinte comandos:

* `aws s3 rm s3://live-gft-iac --recursive`
* `aws s3 rb s3://live-gft-iac`

## Referências

* [Exemplos de template CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/sample-templates-services-us-west-2.html)
* [Repositório com exemplo de templates](https://github.com/awslabs/aws-cloudformation-templates)
* [Documentação dos recursos disponíveis para CloudFormation](https://docs.aws.amazon.com/pt_br/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)
* [Trabalhar com pilhas aninhadas no CloudFormation](https://docs.aws.amazon.com/pt_br/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html)