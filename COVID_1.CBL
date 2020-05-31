      ******************************************************************
      * Author:    CCastellan
      * Date:      31/05/2020
      * Purpose:   Learn Cobol - Covid summary report from
      / https://api.covid19api.com/summary
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. pandemic_rpt.
      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *
       CONFIGURATION SECTION.
           SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT OPTIONAL arquivo_covid
           ASSIGN TO "c.csvw"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS  MODE IS SEQUENTIAL.

      *-----------------------------------------------------------------
       DATA DIVISION.
      *
       FILE SECTION.
      *
       FD  arquivo_covid.
       01  fd_record.
           05 rec                      pic X(196).
      *
       WORKING-STORAGE SECTION.
      *
       01  Header_1.
           05 FILLER                 PIC X(059) value spaces.
           05 FILLER                 PIC X(008) value "New".
           05 FILLER                 PIC X(025) value "Total".
           05 FILLER                 PIC X(029) value "Total".
           05 FILLER                 PIC X(005) value "Total".
      *
       01  Header_2.
           05 FILLER                 PIC X(008) value spaces.
           05 FILLER                 PIC X(012) value "Country Code".
           05 FILLER                 PIC X(038) value " - Country".
           05 FILLER                 PIC X(007) value "Cases".
           05 FILLER                 PIC X(015) value "New Cases".
           05 FILLER                 PIC X(011) value "Fatality".
           05 FILLER                 PIC X(014) value "Fatality".
           05 FILLER                 PIC X(015) value "Recover".
           05 FILLER                 PIC X(015) value "Recover".
           05 FILLER                 PIC X(004) value "Date".
      *
       01  Header_3.
           05 FILLER                 PIC X(144) value all "=".
      *
       01  Line_1.
           05 ln_country.
               10 ln_country_code    PIC X(002).
               10 FILLER             PIC X(003) value " - ".
               10 country_ln         PIC X(045).
                  05 ln_new_cases    PIC ZZZZ.ZZZ.ZZ9.
           05 ln_total_cases         PIC ZZZZ.ZZZ.ZZ9.
           05 ln_fatalidades         PIC ZZZZ.ZZZ.ZZ9.
           05 ln_total_fatalidades   PIC ZZZZ.ZZZ.ZZ9.
           05 ln_recuperados         PIC ZZZZ.ZZZ.ZZ9.
           05 ln_total_recuperados   PIC ZZZZ.ZZZ.ZZ9.
           05 FILLER                 PIC X(003) value spaces.
           05 ln_date.
               10 ln_day             PIC 9(002).
               10 FILLER             PIC X(001) value "/".
               10 ln_month           PIC 9(002).
               10 FILLER             PIC X(001) value "/".
               10 ln_year            PIC 9(004).
               10 FILLER             PIC X(001) value " ".
               10 ln_hour            PIC 9(002).
               10 FILLER             PIC X(001) value ":".
               10 ln_minute          PIC 9(002).
               10 FILLER             PIC X(001) value ":".
               10 ln_second          PIC 9(002).
      *
       01  ws_eof_sw                 PIC X(001) value "n".
           88 eof_sw                 value "y".
           88 not_eof_sw             value "n".
      *
       01 ws_rec.
           05 country_rec.
               10 rec_country        PIC X(045) VALUE SPACES.
               10 rec_country_code   PIC X(002).
               10 rec_slug           PIC X(045).
           05 rec_new_cases          PIC ZZZZ.ZZZ.ZZ9.
           05 rec_total_cases        PIC ZZZZ.ZZZ.ZZ9.
           05 rec_fatalidades        PIC ZZZZ.ZZZ.ZZ9.
           05 rec_total_fatalidades  PIC ZZZZ.ZZZ.ZZ9.
           05 rec_recuperados        PIC ZZZZ.ZZZ.ZZ9.
           05 rec_total_recuperados  PIC ZZZZ.ZZZ.ZZ9.
           05 rec_date.
               10 rec_year           PIC 9(004).
               10 FILLER             PIC X(001) value "/".
               10 rec_month          PIC 9(002).
               10 FILLER             PIC X(001) value "/".
               10 rec_day            PIC 9(002).
               10 rec_t              PIC X(001).
               10 rec_hour           PIC 9(002).
               10 FILLER             PIC X(001) value ":".
               10 rec_minute         PIC 9(002).
               10 FILLER             PIC X(001) value ":".
               10 rec_second         PIC 9(002).
               10 rec_z              PIC X(001).
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *
       MAIN-PROCEDURE.

           OPEN INPUT arquivo_covid.

           DISPLAY Header_1.
           DISPLAY Header_2.
           DISPLAY Header_3.

           PERFORM LER.
           PERFORM processar_arquivo UNTIL eof_sw.

           CLOSE arquivo_covid.

           STOP RUN.
      *
       processar_arquivo.
           DISPLAY Line_1.
           PERFORM LER.
      *
       LER.
           READ arquivo_covid
           AT END move "y" to ws_eof_sw.

           UNSTRING
               rec DELIMITED BY ';'
           INTO
               rec_country
               rec_country_code
               rec_slug
               rec_new_cases
               rec_total_cases
               rec_fatalidades
               rec_total_fatalidades
               rec_recuperados
               rec_total_recuperados
               rec_date
           END-UNSTRING.

           move rec_country to country_ln.
           move rec_country_code to ln_country_code.
           move rec_new_cases to ln_new_cases.
           move rec_total_cases to ln_total_cases.
           move rec_fatalidades to ln_fatalidades.
           move rec_total_fatalidades to ln_total_fatalidades.
           move rec_recuperados to ln_recuperados.
           move rec_total_recuperados to ln_total_recuperados.
           move rec_year to ln_year.
           move rec_month to ln_month.
           move rec_day to ln_day.
           move rec_hour to ln_hour.
           move rec_minute to ln_minute.
           move rec_second to ln_second.
      *
       END PROGRAM pandemic_rpt.
