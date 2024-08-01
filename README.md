# Projeto Flutter

Listagem de base de dados (empresas)

Visualização dos Assets em Árvore

Filtro por nome, status e sensor

https://github.com/user-attachments/assets/17f98a18-60d6-4b65-a751-3f22c225b2cc

A arquitetura utilizada no projeto segue uma versão simplificada do Clean Architecture, incorporando princípios do SOLID e usando o Modular para injeção de dependências. A intenção é demonstrar boas práticas e organização de código, mantendo a simplicidade.

Para simular as camadas da arquitetura, foram deixados alguns rethrow no código. Em um caso real, poderiam ser criadas exceções específicas e classes de falhas (failures) para um tratamento adequado.

Para simular as chamadas de serviço e obter os dados, foi criado um mock.

### Testes unitarios
Testes unitários apenas nos models para representar o uso.

### Isolate
Foi utilizado Isolate para construir a árvore de dados, garantindo que a animação de carregamento não seja travada e proporcionando uma experiência de usuário mais fluida.

## Versões Utilizadas

- **Flutter:** 3.22.3 (channel stable)
- **Dart:** 3.4.4

## Packages
flutter_modular

result_dart

mobx

dio

## Gerenciamento de Estado

Para o gerenciamento de estado, foi utilizado o **MobX** (Necessita de build runner).

## Rodar o projeto

```sh
flutter pub get

fvm flutter packages pub run build_runner build --delete-conflicting-outputs

$ flutter run
