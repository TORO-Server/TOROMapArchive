       IDENTIFICATION DIVISION.
       PROGRAM-ID. GenerateSite.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile ASSIGN TO 'FILE-LIST.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT HtmlFile ASSIGN TO 'index.html'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ReadmeFile ASSIGN TO 'README.md'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD InputFile.
       01 InputRecord PIC X(256).
       FD HtmlFile.
       01 HtmlRecord PIC X(1024).
       FD ReadmeFile.
       01 ReadmeRecord PIC X(600).

       WORKING-STORAGE SECTION.
       01 EOF-FLAG PIC X VALUE 'N'.
           88 End-Of-File VALUE 'Y'.
           88 Not-End-Of-File VALUE 'N'.
       01 File-Name PIC X(256).

       PROCEDURE DIVISION.
      *> cobol-lint CL002 main-procedure
       Main-Procedure.
           OPEN INPUT InputFile
           OPEN OUTPUT HtmlFile
           OPEN OUTPUT ReadmeFile
           PERFORM Write-Header
           PERFORM UNTIL End-Of-File
               READ InputFile
                   AT END
                       SET End-Of-File TO TRUE
                   NOT AT END
                       PERFORM Write-Element
               END-READ
           END-PERFORM
           PERFORM Write-Footer
           CLOSE InputFile
           CLOSE HtmlFile
           CLOSE ReadmeFile
           STOP RUN.

       Write-Header.
           MOVE '<!DOCTYPE html>' TO HtmlRecord
           WRITE HtmlRecord
           MOVE "<html lang='ja'>" TO HtmlRecord
           WRITE HtmlRecord
           MOVE '<head>' TO HtmlRecord
           WRITE HtmlRecord
           MOVE "<meta charset='utf-8'>" TO HtmlRecord
           WRITE HtmlRecord
           MOVE '<title>TOROMapArchive</title>' TO HtmlRecord
           WRITE HtmlRecord
           MOVE '</head>' TO HtmlRecord
           WRITE HtmlRecord
           MOVE '<body>' TO HtmlRecord
           WRITE HtmlRecord
           MOVE '<h1>TOROMapArchive</h1>' TO HtmlRecord
           WRITE HtmlRecord.

       Write-Footer.
           MOVE '</body>' TO HtmlRecord
           WRITE HtmlRecord
           MOVE '</html>' TO HtmlRecord
           WRITE HtmlRecord.

       Write-Element.
           MOVE FUNCTION TRIM(InputRecord) TO File-Name
           IF File-Name = SPACES
               EXIT PARAGRAPH
           END-IF
           MOVE SPACES TO HtmlRecord
           STRING
               "<h2><a href='" DELIMITED BY SIZE
               FUNCTION TRIM(File-Name) DELIMITED BY SIZE
               "'>" DELIMITED BY SIZE
               FUNCTION TRIM(File-Name) DELIMITED BY SIZE
               '</a></h2>' DELIMITED BY SIZE
               INTO HtmlRecord
           END-STRING
           WRITE HtmlRecord
           MOVE SPACES TO HtmlRecord
           STRING
               "<p><a href='" DELIMITED BY SIZE
               FUNCTION TRIM(File-Name) DELIMITED BY SIZE
               "'><img src='" DELIMITED BY SIZE
               FUNCTION TRIM(File-Name) DELIMITED BY SIZE
               "' alt='" DELIMITED BY SIZE
               FUNCTION TRIM(File-Name) DELIMITED BY SIZE
               "'></a></p>" DELIMITED BY SIZE
               INTO HtmlRecord
           END-STRING
           WRITE HtmlRecord
           MOVE SPACES TO ReadmeRecord
           STRING
               '## [' DELIMITED BY SIZE
               FUNCTION TRIM(File-Name) DELIMITED BY SIZE
               '](' DELIMITED BY SIZE
               FUNCTION TRIM(File-Name) DELIMITED BY SIZE
               ')' DELIMITED BY SIZE
               INTO ReadmeRecord
           END-STRING
           WRITE ReadmeRecord.
