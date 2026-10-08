`timescale 1ns / 1ps

module tb_railway();

    // Inputs
    reg E;
    reg W;
    reg PRI;

    reg P1_BUSY;
    reg P2_BUSY;
    reg P3_BUSY;

    // Outputs
    wire E_GREEN;
    wire E_RED;

    wire W_GREEN;
    wire W_RED;

    wire E_P1;
    wire E_P2;
    wire E_P3;

    wire W_P1;
    wire W_P2;
    wire W_P3;

    wire P1_FREE;
    wire P2_FREE;
    wire P3_FREE;

    wire P1_BUSY_LED;
    wire P2_BUSY_LED;
    wire P3_BUSY_LED;


    // =================================================
    // DUT INSTANTIATION
    // =================================================

    railway railway_1(

        .E(E),
        .W(W),
        .PRI(PRI),

        .P1_BUSY(P1_BUSY),
        .P2_BUSY(P2_BUSY),
        .P3_BUSY(P3_BUSY),

        .E_GREEN(E_GREEN),
        .E_RED(E_RED),

        .W_GREEN(W_GREEN),
        .W_RED(W_RED),

        .E_P1(E_P1),
        .E_P2(E_P2),
        .E_P3(E_P3),

        .W_P1(W_P1),
        .W_P2(W_P2),
        .W_P3(W_P3),

        .P1_FREE(P1_FREE),
        .P2_FREE(P2_FREE),
        .P3_FREE(P3_FREE),

        .P1_BUSY_LED(P1_BUSY_LED),
        .P2_BUSY_LED(P2_BUSY_LED),
        .P3_BUSY_LED(P3_BUSY_LED)
    );


    // =================================================
    // TEST CASES
    // =================================================

    initial begin

        // ---------------------------------------------
        // CASE 1
        // No trains, all platforms free
        // ---------------------------------------------
        E = 0;
        W = 0;
        PRI = 0;

        P1_BUSY = 0;
        P2_BUSY = 0;
        P3_BUSY = 0;

        #10;


        // ---------------------------------------------
        // CASE 2
        // East train only
        // All platforms free
        // East should get P1
        // ---------------------------------------------
        E = 1;
        W = 0;

        #10;


        // ---------------------------------------------
        // CASE 3
        // East train only
        // P1 busy, P2 and P3 free
        // East should get P2
        // ---------------------------------------------
        P1_BUSY = 1;
        P2_BUSY = 0;
        P3_BUSY = 0;

        #10;


        // ---------------------------------------------
        // CASE 4
        // East train only
        // Only P3 free
        // East should get P3
        // ---------------------------------------------
        P1_BUSY = 1;
        P2_BUSY = 1;
        P3_BUSY = 0;

        #10;


        // ---------------------------------------------
        // CASE 5
        // West train only
        // All platforms free
        // West should get P1
        // ---------------------------------------------
        E = 0;
        W = 1;

        P1_BUSY = 0;
        P2_BUSY = 0;
        P3_BUSY = 0;

        #10;


        // ---------------------------------------------
        // CASE 6
        // West train only
        // P1 busy
        // West should get P2
        // ---------------------------------------------
        P1_BUSY = 1;
        P2_BUSY = 0;
        P3_BUSY = 0;

        #10;


        // ---------------------------------------------
        // CASE 7
        // Both trains
        // All platforms free
        // East → P1
        // West → P2
        // ---------------------------------------------
        E = 1;
        W = 1;
        PRI = 0;

        P1_BUSY = 0;
        P2_BUSY = 0;
        P3_BUSY = 0;

        #10;


        // ---------------------------------------------
        // CASE 8
        // Both trains
        // P1 busy
        // East → P2
        // West → P3
        // ---------------------------------------------
        P1_BUSY = 1;
        P2_BUSY = 0;
        P3_BUSY = 0;

        #10;


        // ---------------------------------------------
        // CASE 9
        // Both trains
        // Only P1 free
        // PRI = 0 → East
        // ---------------------------------------------
        P1_BUSY = 0;
        P2_BUSY = 1;
        P3_BUSY = 1;
        PRI = 0;

        #10;


        // ---------------------------------------------
        // CASE 10
        // Both trains
        // Only P1 free
        // PRI = 1 → West
        // ---------------------------------------------
        PRI = 1;

        #10;


        // ---------------------------------------------
        // CASE 11
        // Both trains
        // Only P2 free
        // PRI = 0 → East
        // ---------------------------------------------
        P1_BUSY = 1;
        P2_BUSY = 0;
        P3_BUSY = 1;
        PRI = 0;

        #10;


        // ---------------------------------------------
        // CASE 12
        // Both trains
        // Only P2 free
        // PRI = 1 → West
        // ---------------------------------------------
        PRI = 1;

        #10;


        // ---------------------------------------------
        // CASE 13
        // Both trains
        // Only P3 free
        // PRI = 0 → East
        // ---------------------------------------------
        P1_BUSY = 1;
        P2_BUSY = 1;
        P3_BUSY = 0;
        PRI = 0;

        #10;


        // ---------------------------------------------
        // CASE 14
        // Both trains
        // Only P3 free
        // PRI = 1 → West
        // ---------------------------------------------
        PRI = 1;

        #10;


        // ---------------------------------------------
        // CASE 15
        // Both trains
        // All platforms busy
        // Both RED
        // ---------------------------------------------
        P1_BUSY = 1;
        P2_BUSY = 1;
        P3_BUSY = 1;

        #10;


        // ---------------------------------------------
        // CASE 16
        // No trains
        // All platforms busy
        // ---------------------------------------------
        E = 0;
        W = 0;

        #10;


        $finish;

    end

endmodule