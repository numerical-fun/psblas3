      SUBROUTINE ZCSRSM(TRANST,M,N,UNITD,D,ALPHA,DESCRA,A,JA,IA,
     *                  B,LDB,BETA,C,LDC,WORK,LWORK)
      COMPLEX*16 ALPHA, BETA
      INTEGER    LDB, LDC, LWORK, M, N
      CHARACTER  UNITD, TRANST
      COMPLEX*16 A(*), B(LDB,*), C(LDC,*), D(*), WORK(*)
      INTEGER    IA(*), JA(*)
      CHARACTER  DESCRA*11
      INTEGER    I, K
      CHARACTER  DIAG, UPLO
      EXTERNAL    XERBLA
      IF ((ALPHA.NE.(1.D0, 0.D0)).OR.
     +    (BETA.NE.(0.D0, 0.D0))) THEN
         CALL XERBLA('ZCSSM ',9)
         RETURN
      ENDIF
      UPLO = '?'
      IF (DESCRA(1:1).EQ.'T' .AND. DESCRA(2:2).EQ.'U') UPLO = 'U'
      IF (DESCRA(1:1).EQ.'T' .AND. DESCRA(2:2).EQ.'L') UPLO = 'L'
      IF (UPLO.EQ.'?') THEN
         CALL XERBLA('ZCSSM ',9)
         RETURN
      END IF
      IF (DESCRA(3:3).EQ.'N') DIAG = 'N'
      IF (DESCRA(3:3).EQ.'U') DIAG = 'U'
      IF(UNITD.EQ.'B') THEN
         CALL XERBLA('ZCSSM ',9)
         RETURN
      ENDIF
      IF (UNITD.EQ.'R') THEN
         DO 40 I = 1, N
            DO 20 K = 1, M
               B(K,I) = B(K,I)*D(K)
   20       CONTINUE
   40    CONTINUE
      END IF

      DO 60 I = 1, N
         CALL ZSRSV(UPLO,TRANST,DIAG,M,A,JA,IA,B(1,I),C(1,I))
   60 CONTINUE
      IF (UNITD.EQ.'L') THEN
         DO 45 I = 1, N
            DO 25 K = 1, M
               C(K,I) = C(K,I)*D(K)
   25       CONTINUE
   45    CONTINUE
      END IF
      RETURN
      END


