# blocklist-ifrn

Este conjunto de scripts atua como um auxiliar para o servidor de e-mails (Exchange), realizando o gerenciamento de uma base de dados externa contendo domínios e endereços de e-mail maliciosos bloqueados. Como o Exchange não exibe informações detalhadas, como data e hora do bloqueio, os scripts foram desenvolvidos para registrar essas informações e acompanhar as alterações feitas no servidor.

Um script principal facilita a inclusão e exclusão de entradas diretamente no Exchange, enquanto scripts auxiliares são executados logo após cada operação, aproveitando os dados inseridos para manter a base externa atualizada de forma automatizada.
