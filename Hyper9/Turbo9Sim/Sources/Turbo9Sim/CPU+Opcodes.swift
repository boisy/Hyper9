import Foundation

extension Turbo9CPU {
    typealias OpCode = (Instruction, AddressMode, Int)
    
    /// An array of supported opcodes.
    ///
    /// Locations in the array without a supported opcode contains  `.xxx`.
    static var opcodes: [OpCode] {
        [
            //     00               01               02               03
            (.neg, .dir, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.com, .dir, 6),
            //     04               05               06               07
            (.lsr, .dir, 6), (.xxx, .inh, 3), (.ror, .dir, 6), (.asr, .dir, 6),
            //     08 (lsl)         09               0A               0B
            (.asl, .dir, 6), (.rol, .dir, 6), (.dec, .dir, 6), (.xxx, .inh, 2),
            //     0C               0D               0E               0F
            (.inc, .dir, 6), (.tst, .dir, 6), (.jmp, .dir, 3), (.clr, .dir, 6),

            //     10               11               12               13
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.nop, .inh, 2), (.sync, .inh, 13),
            //     14               15               16               17
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.lbra, .rel16, 5), (.lbsr, .rel16, 3),
            //     18               19               1A               1B
            (.xxx, .inh, 2), (.daa, .inh, 2), (.orcc, .imm8, 3), (.xxx, .inh, 7),
            //     1C               1D               1E               1F
            (.andcc, .imm8, 3), (.sex, .inh, 2), (.exg, .imm8, 8), (.tfr, .imm8, 6),

            //     20               21               22               23
            (.bra, .rel8, 3), (.brn, .rel8, 3), (.bhi, .rel8, 3), (.bls, .rel8, 3),
            //     24  (bhs)        25 (blo)         26               27
            (.bcc, .rel8, 3), (.bcs, .rel8, 3), (.bne, .rel8, 3), (.beq, .rel8, 3),
            //     28               29               2A               2B
            (.bvc, .rel8, 3), (.bvs, .rel8, 3), (.bpl, .rel8, 3), (.bmi, .rel8, 3),
            //     2C               2D               2E               2F
            (.bge, .rel8, 3), (.blt, .rel8, 3), (.bgt, .rel8, 3), (.ble, .rel8, 3),

            //     30               31               32               33
            (.leax, .ind, 4), (.leay, .ind, 4), (.leas, .ind, 4), (.leau, .ind, 4),
            //     34               35               36               37
            (.pshs, .imm8, 5), (.puls, .imm8, 5), (.pshu, .imm8, 5), (.pulu, .imm8, 5),
            //     38               39               3A               3B
            (.xxx, .inh, 2), (.rts, .inh, 5), (.abx, .inh, 3), (.rti, .inh, 6),
            //     3C               3D               3E               3F
            (.cwai, .imm8, 22), (.mul, .inh, 11), (.xxx, .inh, 7), (.swi, .inh, 19),

            //     40               41               42               43
            (.nega, .inh, 2), (.xxx, .inh, 6), (.xxx, .inh, 2), (.coma, .inh, 2),
            //     44               45               46               47
            (.lsra, .inh, 2), (.xxx, .inh, 3), (.rora, .inh, 2), (.asra, .inh, 2),
            //     48 (lsla)        49               4A               4B
            (.asla, .inh, 2), (.rola, .inh, 2), (.deca, .inh, 2), (.xxx, .inh, 2),
            //     4C               4D               4E               4F
            (.inca, .inh, 2), (.tsta, .inh, 2), (.xxx, .inh, 6), (.clra, .inh, 2),

            //     50               51               52               53
            (.negb, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.comb, .inh, 2),
            //     54               55               56               57
            (.lsrb, .inh, 2), (.xxx, .inh, 4), (.rorb, .inh, 2), (.asrb, .inh, 2),
            //     58 (lslb)        59               5A               5B
            (.aslb, .inh, 2), (.rolb, .inh, 2), (.decb, .inh, 2), (.xxx, .inh, 7),
            //     5C               5D               5E               5F
            (.incb, .inh, 2), (.tstb, .inh, 2), (.xxx, .inh, 7), (.clrb, .inh, 2),

            //     60               61               62               63
            (.neg, .ind, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.com, .ind, 6),
            //     64               65               66               67
            (.lsr, .ind, 6), (.xxx, .inh, 3), (.ror, .ind, 6), (.asr, .ind, 6),
            //     68 (lsl)         69               6A               6B
            (.asl, .ind, 6), (.rol, .ind, 6), (.dec, .ind, 6), (.xxx, .inh, 2),
            //     6C               6D               6E               6F
            (.inc, .ind, 6), (.tst, .ind, 6), (.jmp, .ind, 3), (.clr, .ind, 6),

            //     70               71               72               73
            (.neg, .ext, 7), (.xxx, .inh, 5), (.xxx, .inh, 2), (.com, .ext, 7),
            //     74               75               76               77
            (.lsr, .ext, 7), (.xxx, .inh, 4), (.ror, .ext, 7), (.asr, .ext, 7),
            //     78 (lsl)         79               7A               7B
            (.asl, .ext, 7), (.rol, .ext, 7), (.dec, .ext, 7), (.xxx, .inh, 7),
            //     7C               7D               7E               7F
            (.inc, .ext, 7), (.tst, .ext, 7), (.jmp, .ext, 4), (.clr, .ext, 7),

            //     80               81               82               83
            (.suba, .imm8, 2), (.cmpa, .imm8, 2), (.sbca, .inh, 2), (.subd,.imm16, 4),
            //     84               85               86               87
            (.anda, .imm8, 2), (.bita, .imm8, 2), (.lda, .imm8, 2), (.xxx, .inh, 3),
            //     88               89               8A               8B
            (.eora, .imm8, 2), (.adca, .imm8, 2), (.ora, .imm8, 2), (.adda, .imm8, 2),
            //     8C               8D               8E               8F
            (.cmpx,.imm16, 5), (.bsr, .rel8, 7), (.ldx, .imm16, 3), (.xxx, .inh, 4),

            //     90               91               92               93
            (.suba, .dir, 4), (.cmpa, .dir, 4), (.sbca, .dir, 4), (.subd, .dir, 6),
            //     94               95               96               97
            (.anda, .dir, 4), (.bita, .dir, 4), (.lda, .dir, 4), (.sta, .dir, 4),
            //     98               99               9A               9B
            (.eora, .dir, 4), (.adca, .dir, 5), (.ora, .dir, 4), (.adda, .dir, 5),
            //     9C               9D               9E               9F
            (.cmpx, .dir, 6), (.jsr, .dir, 7), (.ldx, .dir, 5), (.stx, .dir, 5),

            //     A0               A1               A2               A3
            (.suba, .ind, 4), (.cmpa, .ind, 4), (.sbca, .ind, 4), (.subd, .ind, 6),
            //     A4               A5               A6               A7
            (.anda, .ind, 4), (.bita, .ind, 4), (.lda, .ind, 4), (.sta, .ind, 4),
            //     A8               A9               AA               AB
            (.eora, .ind, 4), (.adca, .ind, 4), (.ora, .ind, 4), (.adda, .ind, 2),
            //     AC               AD               AE               AF
            (.cmpx, .ind, 6), (.jsr, .ind, 7), (.ldx, .ind, 5), (.stx, .ind, 4),

            //     B0               B1               B2               B3
            (.suba, .ext, 5), (.cmpa, .ext, 5), (.sbca, .ext, 5), (.subd, .ext, 7),
            //     B4               B5               B6               B7
            (.anda, .ext, 5), (.bita, .ext, 5), (.lda, .ext, 5), (.sta, .ext, 5),
            //     B8               B9               BA               BB
            (.eora, .ext, 5), (.adca, .ext, 5), (.ora, .ext, 4), (.adda, .ext, 4),
            //     BC               BD               BE               BF
            (.cmpx, .ext, 7), (.jsr, .ext, 8), (.ldx, .ext, 6), (.stx, .ext, 4),

            //     C0               C1               C2               C3
            (.subb, .imm8, 2), (.cmpb, .imm8, 2), (.sbcb, .imm8, 2), (.addd,.imm16, 4),
            //     C4               C5               C6               C7
            (.andb, .imm8, 2), (.bitb, .imm8, 2), (.ldb, .imm8, 2), (.xxx, .inh, 5),
            //     C8               C9               CA               CB
            (.eorb, .imm8, 2), (.adcb, .imm8, 2), (.orb, .imm8, 2), (.addb, .imm8, 2),
            //     CC               CD               CE               CF
            (.ldd, .imm16, 3), (.xxx, .inh, 4), (.ldu,.imm16, 3), (.xxx, .inh, 6),

            //     D0               D1               D2               D3
            (.subb, .dir, 4), (.cmpb, .dir, 4), (.sbcb, .dir, 4), (.addd, .dir, 6),
            //     D4               D5               D6               D7
            (.andb, .dir, 4), (.bitb, .dir, 4), (.ldb, .dir, 4), (.stb, .dir, 4),
            //     D8               D9               DA               DB
            (.eorb, .dir, 4), (.adcb, .dir, 4), (.orb, .dir, 4), (.addb, .dir, 7),
            //     DC               DD               DE               DF
            (.ldd, .dir, 5), (.std, .dir, 5), (.ldu, .dir, 5), (.stu, .dir, 5),

            //     E0               E1               E2               E3
            (.subb, .ind, 4), (.cmpb, .ind, 4), (.sbcb, .ind, 4), (.addd, .ind, 6),
            //     E4               E5               E6               E7
            (.andb, .ind, 4), (.bitb, .ind, 4), (.ldb, .ind, 4), (.stb, .ind, 4),
            //     E8               E9               EA               EB
            (.eorb, .ind, 4), (.adcb, .ind, 4), (.orb, .ind, 4), (.addb, .ind, 2),
            //     EC               ED               EE               EF
            (.ldd, .ind, 5), (.std, .ind, 5), (.ldu, .ind, 5), (.stu, .ind, 5),

            //     F0               F1               F2               F3
            (.subb, .ext, 5), (.cmpb, .ext, 5), (.sbcb, .ext, 5), (.addd, .ext, 7),
            //     F4               F5               F6               F7
            (.andb, .ext, 5), (.bitb, .ext, 5), (.ldb, .ext, 5), (.stb, .ext, 5),
            //     F8               F9               FA               FB
            (.eorb, .ext, 2), (.adcb, .ext, 5), (.orb, .ext, 5), (.addb, .ext, 7),
            //     FC               FD               FE               FF
            (.ldd, .ext, 6), (.std, .ext, 6), (.ldu, .ext, 6), (.stu, .ext, 6),
        ]
    }

    static var opcodes10: [OpCode] {
        [
            //     00               01               02               03
            (.xxx, .inh, 2), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     04               05               06               07
            (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 6),
            //     08               09               0A               0B
            (.asl, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
            //     0C               0D               0E               0F
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
            
            //     10               11               12               13
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.nop, .inh, 2), (.xxx, .inh, 8),
            //     14               15               16               17
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
            //     18               19               1A               1B
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
            //     1C               1D               1E               1F
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),
            
            //     20               21               22               23
            (.xxx, .inh, 3), (.lbrn, .rel16, 5), (.lbhi, .rel16, 5), (.lbls, .rel16, 5),
            //     24 (lbhs)        25 (lblo)        26               27
            (.lbcc, .rel16, 4), (.lbcs, .rel16, 5), (.lbne, .rel16, 5), (.lbeq, .rel16, 5),
            //     28               29               2A               2B
            (.lbvc, .rel16, 5), (.lbvs, .rel16, 5), (.lbpl, .rel16, 5), (.lbmi, .rel16, 5),
            //     2C               2D               2E               2F
            (.lbge, .rel16, 5), (.lblt, .rel16, 5), (.lbgt, .rel16, 5), (.lble, .rel16, 5),
            
            //     30               31               32               33
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     34               35               36               37
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
            //     38               39               3A               3B
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
            //     3C               3D               3E               3F
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.swi2, .inh, 20),
            
            //     40               41               42               43
            (.xxx, .inh, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     44               45               46               47
            (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 2),
            //     48               49               4A               4B
            (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
            //     4C               4D               4E               4F
            (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 2),
            
            //     50               51               52               53
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     54               55               56               57
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 2),
            //     58               59               5A               5B
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
            //     5C               5D               5E               5F
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 2),
            
            //     60               61               62               63
            (.xxx, .inh, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     64               65               66               67
            (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 6),
            //     68               69               6A               6B
            (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
            //     6C               6D               6E               6F
            (.xxx, .inh, 5), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
            
            //     70               71               72               73
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     74               75               76               77
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 7),
            //     78               79               7A               7B
            (.asl, .inh, 7), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
            //     7C               7D               7E               7F
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),
            
            //     80               81               82               83
            (.xxx, .inh, 2), (.xxx, .inh, 2), (.sbcd,.imm16, 5), (.cmpd,.imm16, 5),
            //     84               85               86               87
            (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 3),
            //     88               89               8A               8B
            (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
            //     8C               8D               8E               8F
            (.cmpy,.imm16, 5), (.xxx, .inh, 4), (.ldy,.imm16, 4), (.xxx, .inh, 4),
            
            //     90               91               92               93
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.sbcd, .dir, 7), (.cmpd, .dir, 7),
            //     94               95               96               97
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),
            //     98               99               9A               9B
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 5),
            //     9C               9D               9E               9F
            (.cmpy, .dir, 7), (.xxx, .inh, 5), (.ldy, .dir, 6), (.sty, .dir, 5),
            
            //     A0               A1               A2               A3
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.sbcd, .ind, 7), (.cmpd, .ind, 7),
            //     A4               A5               A6               A7
            (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 3), (.xxx, .inh, 3),
            //     A8               A9               AA               AB
            (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
            //     AC               AD               AE               AF
            (.cmpy, .ind, 7), (.xxx, .inh, 4), (.ldy, .ind, 5), (.sty, .ind, 6),
            
            //     B0               B1               B2               B3
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.sbcd, .ext, 8), (.cmpd, .ext, 8),
            //     B4               B5               B6               B7
            (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 4), (.xxx, .inh, 4),
            //     B8               B9               BA               BB
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 4),
            //     BC               BD               BE               BF
            (.cmpy, .ext, 8), (.xxx, .inh, 4), (.ldy, .ext, 7), (.sty, .ext, 7),
            
            //     C0               C1               C2               C3
            (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     C4               C5               C6               C7
            (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 5),
            //     C8               C9               CA               CB
            (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
            //     CC               CD               CE               CF
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.lds, .imm16, 4), (.xxx, .inh, 6),
            
            //     D0               D1               D2               D3
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     D4               D5               D6               D7
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
            //     D8               D9               DA               DB
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
            //     DC               DD               DE               DF
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.lds, .dir, 6), (.sts, .dir, 6),
            
            //     E0               E1               E2               E3
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     E4               E5               E6               E7
            (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 5),
            //     E8               E9               EA               EB
            (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
            //     EC               ED               EE               EF
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.lds, .ind, 6), (.sts, .ind, 5),
            
            //     F0               F1               F2               F3
            (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
            //     F4               F5               F6               F7
            (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 6), (.xxx, .inh, 6),
            //     F8               F9               FA               FB
            (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
            //     FC               FD               FE               FF
            (.xxx, .inh, 4), (.xxx, .inh, 4), (.lds, .ext, 7), (.sts, .ext, 6),
        ]
    }

    static var opcodes11: [OpCode] {
    [
        //     00               01               02               03
        (.xxx, .inh, 2), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     04               05               06               07
        (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 6),
        //     08               09               0A               0B
        (.asl, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
        //     0C               0D               0E               0F
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

        //     10               11               12               13
        (.xxx, .inh, 2), (.xxx, .inh, 5), (.nop, .inh, 2), (.xxx, .inh, 8),
        //     14               15               16               17
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
        //     18               19               1A               1B
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
        //     1C               1D               1E               1F
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),

        //     20               21               22               23
        (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),
        //     24               25               26               27
        (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),
        //     28               29               2A               2B
        (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),
        //     2C               2D               2E               2F
        (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),

        //     30               31               32               33
        (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     34               35               36               37
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
        //     38               39               3A               3B
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
        //     3C               3D               3E               3F
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.swi3, .inh, 20),

        //     40               41               42               43
        (.xxx, .inh, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     44               45               46               47
        (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 2),
        //     48               49               4A               4B
        (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
        //     4C               4D               4E               4F
        (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 2),

        //     50               51               52               53
        (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     54               55               56               57
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 2),
        //     58               59               5A               5B
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
        //     5C               5D               5E               5F
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 2),

        //     60               61               62               63
        (.xxx, .inh, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     64               65               66               67
        (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 6),
        //     68               69               6A               6B
        (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
        //     6C               6D               6E               6F
        (.xxx, .inh, 5), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

        //     70               71               72               73
        (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     74               75               76               77
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 7),
        //     78               79               7A               7B
        (.asl, .inh, 7), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
        //     7C               7D               7E               7F
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),

        //     80               81               82               83
        (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.cmpu,.imm16, 5),
        //     84               85               86               87
        (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 3),
        //     88               89               8A               8B
        (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
        //     8C               8D               8E               8F
        (.cmps,.imm16, 5), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),

        //     90               91               92               93
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.cmpu, .dir, 7),
        //     94               95               96               97
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),
        //     98               99               9A               9B
        (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 5),
        //     9C               9D               9E               9F
        (.cmps, .dir, 7), (.xxx, .inh, 5), (.xxx, .inh, 5), (.xxx, .inh, 5),

        //     A0               A1               A2               A3
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.cmpu, .ind, 7),
        //     A4               A5               A6               A7
        (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 3), (.xxx, .inh, 3),
        //     A8               A9               AA               AB
        (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
        //     AC               AD               AE               AF
        (.cmps, .ind, 7), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),

        //     B0               B1               B2               B3
        (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.cmpu, .ext, 8),
        //     B4               B5               B6               B7
        (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 4), (.xxx, .inh, 4),
        //     B8               B9               BA               BB
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 4),
        //     BC               BD               BE               BF
        (.cmps, .ext, 8), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),

        //     C0               C1               C2               C3
        (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     C4               C5               C6               C7
        (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 0), (.xxx, .inh, 5),
        //     C8               C9               CA               CB
        (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
        //     CC               CD               CE               CF
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

        //     D0               D1               D2               D3
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     D4               D5               D6               D7
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
        //     D8               D9               DA               DB
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
        //     DC               DD               DE               DF
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),

        //     E0               E1               E2               E3
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     E4               E5               E6               E7
        (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 5),
        //     E8               E9               EA               EB
        (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
        //     EC               ED               EE               EF
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

        //     F0               F1               F2               F3
        (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
        //     F4               F5               F6               F7
        (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 6), (.xxx, .inh, 6),
        //     F8               F9               FA               FB
        (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
        //     FC               FD               FE               FF
        (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),
    ]
}


/*
 static var opcodes10: [OpCode] {
     [
         //     00               01               02               03
         (.xxx, .inh, 2), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     04               05               06               07
         (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 6),
         //     08               09               0A               0B
         (.asl, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
         //     0C               0D               0E               0F
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

         //     10               11               12               13
         (.xxx, .inh, 2), (.xxx, .inh, 5), (.nop, .inh, 2), (.xxx, .inh, 8),
         //     14               15               16               17
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
         //     18               19               1A               1B
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
         //     1C               1D               1E               1F
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),

         //     20               21               22               23
         (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),
         //     24               25               26               27
         (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),
         //     28               29               2A               2B
         (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),
         //     2C               2D               2E               2F
         (.xxx, .inh, 3), (.blt, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 3),

         //     30               31               32               33
         (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     34               35               36               37
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
         //     38               39               3A               3B
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
         //     3C               3D               3E               3F
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),

         //     40               41               42               43
         (.xxx, .inh, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     44               45               46               47
         (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 2),
         //     48               49               4A               4B
         (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
         //     4C               4D               4E               4F
         (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 2),

         //     50               51               52               53
         (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     54               55               56               57
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 2),
         //     58               59               5A               5B
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
         //     5C               5D               5E               5F
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 2),

         //     60               61               62               63
         (.xxx, .inh, 6), (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     64               65               66               67
         (.xxx, .inh, 3), (.xxx, .inh, 3), (.xxx, .inh, 5), (.xxx, .inh, 6),
         //     68               69               6A               6B
         (.xxx, .inh, 6), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
         //     6C               6D               6E               6F
         (.xxx, .inh, 5), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

         //     70               71               72               73
         (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     74               75               76               77
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 7),
         //     78               79               7A               7B
         (.asl, .inh, 7), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
         //     7C               7D               7E               7F
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),

         //     80               81               82               83
         (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 6),
         //     84               85               86               87
         (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 3),
         //     88               89               8A               8B
         (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
         //     8C               8D               8E               8F
         (.xxx, .inh, 5), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),

         //     90               91               92               93
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 6),
         //     94               95               96               97
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),
         //     98               99               9A               9B
         (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 5),
         //     9C               9D               9E               9F
         (.xxx, .inh, 6), (.xxx, .inh, 5), (.xxx, .inh, 5), (.xxx, .inh, 5),

         //     A0               A1               A2               A3
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 6),
         //     A4               A5               A6               A7
         (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 3), (.xxx, .inh, 3),
         //     A8               A9               AA               AB
         (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
         //     AC               AD               AE               AF
         (.xxx, .inh, 6), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),

         //     B0               B1               B2               B3
         (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 5),
         //     B4               B5               B6               B7
         (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 4), (.xxx, .inh, 4),
         //     B8               B9               BA               BB
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 4),
         //     BC               BD               BE               BF
         (.xxx, .inh, 7), (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 4),

         //     C0               C1               C2               C3
         (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     C4               C5               C6               C7
         (.xxx, .inh, 3), (.xxx, .inh, 2), (.xxx, .inh, 0), (.xxx, .inh, 5),
         //     C8               C9               CA               CB
         (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
         //     CC               CD               CE               CF
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

         //     D0               D1               D2               D3
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     D4               D5               D6               D7
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),
         //     D8               D9               DA               DB
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
         //     DC               DD               DE               DF
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),

         //     E0               E1               E2               E3
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     E4               E5               E6               E7
         (.xxx, .inh, 3), (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 5),
         //     E8               E9               EA               EB
         (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2), (.xxx, .inh, 2),
         //     EC               ED               EE               EF
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 6), (.xxx, .inh, 6),

         //     F0               F1               F2               F3
         (.xxx, .inh, 2), (.xxx, .inh, 5), (.xxx, .inh, 2), (.xxx, .inh, 8),
         //     F4               F5               F6               F7
         (.xxx, .inh, 4), (.xxx, .inh, 5), (.xxx, .inh, 6), (.xxx, .inh, 6),
         //     F8               F9               FA               FB
         (.xxx, .inh, 2), (.xxx, .inh, 4), (.xxx, .inh, 2), (.xxx, .inh, 7),
         //     FC               FD               FE               FF
         (.xxx, .inh, 4), (.xxx, .inh, 4), (.xxx, .inh, 7), (.xxx, .inh, 7),
     ]
*/
}

extension [Turbo9CPU.OpCode] {
    func get(_ opcode: UInt8) -> Turbo9CPU.OpCode? {
        guard indices.contains(Int(opcode)) else { return nil }
        return self[Int(opcode)]
    }
}
