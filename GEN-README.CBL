
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GenerateREADME.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile ASSIGN TO 'FILE-LIST.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD InputFile.
       01 InputRecord PIC X(256).

       WORKING-STORAGE SECTION.
       01 EOF-FLAG PIC X VALUE 'N'.
           88 End-Of-File VALUE 'Y'.
           88 Not-End-Of-File VALUE 'N'.

       PROCEDURE DIVISION.
      *> cobol-lint CL002 main-procedure
       Main-Procedure.
           OPEN INPUT InputFile

           PERFORM UNTIL End-Of-File
               READ InputFile
                   AT END
                       SET End-Of-File TO TRUE
                   NOT AT END
                       DISPLAY "## [" InputRecord "](" InputRecord ")"
               END-READ
           END-PERFORM

           CLOSE InputFile
           STOP RUN.
