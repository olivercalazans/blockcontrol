<h1 align="center"> BlockControl </h1>

## 🌐 English

This set of scripts serves as an assistant for the Exchange email server, managing an external database containing blocked domains, email addresses, and malicious IPs. Since Exchange does not display detailed information such as the date and time of the block, the scripts were developed to log this data and track changes made to the server.

Developed exclusively with PowerShell and using only the native .NET Framework on Windows, the system includes a main script that simplifies the addition and removal of entries directly in Exchange. After each operation, auxiliary scripts are automatically executed, leveraging the newly inserted data to keep the external database up to date.

This approach avoids task repetition and, in many cases, eliminates the need to manually search for blocked IPs, domains, or email addresses in the list.


## 🇧🇷 Português

Este conjunto de scripts atua como um auxiliar para o servidor de e-mails Exchange, realizando o gerenciamento de uma base de dados externa contendo domínios, endereços de e-mail e IPs maliciosos bloqueados. Como o Exchange não exibe informações detalhadas, como data e hora do bloqueio, os scripts foram desenvolvidos para registrar essas informações e acompanhar as alterações realizadas no servidor.

Desenvolvido exclusivamente com PowerShell e utilizando apenas a .NET Framework nativa do Windows, o sistema conta com um script principal que facilita a inclusão e exclusão de entradas diretamente no Exchange. Após cada operação, scripts auxiliares são executados automaticamente, aproveitando os dados recém-inseridos para manter a base externa atualizada.

Dessa forma, evita-se a repetição de tarefas e, em muitos casos, a necessidade de buscar manualmente o IP, domínio ou e-mail bloqueado na lista.
