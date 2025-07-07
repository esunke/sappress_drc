# sappress_drc

Dieses Repository enthält ABAP-Codebeispiele, die mit abapGit verwaltet werden. Die Beispiele demonstrieren die Implementierung von BAdI-Implementierungen und Funktionsbausteinen im Kontext von SAP Document and Reporting Compliance (DRC).

## Inhalt

- **BAdI-Implementierung für HU**  
  Enthält die Klasse [`ZCL_EDOC_ADAPTOR_HU_ADD_MAIL`](src/zcl_edoc_adaptor_hu_add_mail.clas.abap) sowie die zugehörige BAdI-Implementierung [`ZEI_EDOC_ADAPTOR_HU_ADDMAIL`](src/zei_edoc_adaptor_hu_addmail.enho.xml).

- **Funktionsbaustein zur Fehlerbenachrichtigung**  
  Der Funktionsbaustein [`ZEDOC_HU_ERROR_NOTIFICATION`](src/z_edoc.fugr.zedoc_hu_error_notification.abap) versendet Benachrichtigungen per E-Mail bei Fehlern im eDocument-Prozess.

## Import ins eigene SAP-System mit abapGit

1. **abapGit installieren**  
   Lade das abapGit-Report aus [https://abapgit.org](https://abapgit.org) herunter und installiere es in deinem SAP-System.

2. **Repository als Online-Repo hinzufügen**  
   - Öffne abapGit im SAP GUI (`/nSABAPGIT`).
   - Wähle „Neues Online-Repository“.
   - Gib die URL dieses Git-Repositories an.

3. **Repository synchronisieren**  
   - Wähle das Repository in abapGit aus.
   - Klicke auf „Pull“, um die Objekte in dein SAP-System zu importieren.

4. **Aktivieren**  
   - Nach dem Import müssen die Objekte ggf. noch aktiviert werden.

Weitere Informationen findest du in der [abapGit Dokumentation](https://docs.abapgit.org/).

---
*Hinweis: Die Beispiele dienen Demonstrationszwecken und sollten vor dem Einsatz in Produktivsystemen geprüft und ggf. angepasst werden.*