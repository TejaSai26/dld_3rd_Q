`timescale 1ns / 1ps

module railway(

    // Train inputs
    input E,
    input W,
    input PRI,

    // Platform occupancy inputs
    input P1_BUSY,
    input P2_BUSY,
    input P3_BUSY,

    // Railway signals
    output E_GREEN,
    output E_RED,
    output W_GREEN,
    output W_RED,

    // East route indicators
    output E_P1,
    output E_P2,
    output E_P3,

    // West route indicators
    output W_P1,
    output W_P2,
    output W_P3,

    // Platform indicators
    output P1_FREE,
    output P2_FREE,
    output P3_FREE,

    output P1_BUSY_LED,
    output P2_BUSY_LED,
    output P3_BUSY_LED
);

    // Internal route signals
    reg e_p1, e_p2, e_p3;
    reg w_p1, w_p2, w_p3;

    reg e_green;
    reg w_green;




    assign P1_FREE = ~P1_BUSY;
    assign P2_FREE = ~P2_BUSY;
    assign P3_FREE = ~P3_BUSY;

    assign P1_BUSY_LED = P1_BUSY;
    assign P2_BUSY_LED = P2_BUSY;
    assign P3_BUSY_LED = P3_BUSY;



    always @(*) begin

        // Default values
        e_p1 = 0;
        e_p2 = 0;
        e_p3 = 0;

        w_p1 = 0;
        w_p2 = 0;
        w_p3 = 0;

        e_green = 0;
        w_green = 0;


        // =================================================
        // ONLY EAST TRAIN

        if (E && !W) begin

            if (!P1_BUSY) begin
                e_p1 = 1;
                e_green = 1;
            end

            else if (!P2_BUSY) begin
                e_p2 = 1;
                e_green = 1;
            end

            else if (!P3_BUSY) begin
                e_p3 = 1;
                e_green = 1;
            end

        end


        // =================================================
        // ONLY WEST TRAIN
        // =================================================

        else if (!E && W) begin

            if (!P1_BUSY) begin
                w_p1 = 1;
                w_green = 1;
            end

            else if (!P2_BUSY) begin
                w_p2 = 1;
                w_green = 1;
            end

            else if (!P3_BUSY) begin
                w_p3 = 1;
                w_green = 1;
            end

        end


        // =================================================
        // BOTH EAST AND WEST
        // =================================================

        else if (E && W) begin

            // ---------------------------------------------
            // TWO OR MORE PLATFORMS AVAILABLE
            // ---------------------------------------------

            // P1 and P2 free
            if (!P1_BUSY && !P2_BUSY) begin

                e_p1 = 1;
                w_p2 = 1;

                e_green = 1;
                w_green = 1;
            end

            // P1 and P3 free
            else if (!P1_BUSY && P2_BUSY && !P3_BUSY) begin

                e_p1 = 1;
                w_p3 = 1;

                e_green = 1;
                w_green = 1;
            end

            // P2 and P3 free
            else if (P1_BUSY && !P2_BUSY && !P3_BUSY) begin

                e_p2 = 1;
                w_p3 = 1;

                e_green = 1;
                w_green = 1;
            end


            // ---------------------------------------------
            // ONLY ONE PLATFORM AVAILABLE
            // PRI = 0 → EAST
            // PRI = 1 → WEST
            // ---------------------------------------------

            // Only P1 free
            else if (!P1_BUSY && P2_BUSY && P3_BUSY) begin

                if (PRI == 0) begin
                    e_p1 = 1;
                    e_green = 1;
                end
                else begin
                    w_p1 = 1;
                    w_green = 1;
                end

            end

            // Only P2 free
            else if (P1_BUSY && !P2_BUSY && P3_BUSY) begin

                if (PRI == 0) begin
                    e_p2 = 1;
                    e_green = 1;
                end
                else begin
                    w_p2 = 1;
                    w_green = 1;
                end

            end

            // Only P3 free
            else if (P1_BUSY && P2_BUSY && !P3_BUSY) begin

                if (PRI == 0) begin
                    e_p3 = 1;
                    e_green = 1;
                end
                else begin
                    w_p3 = 1;
                    w_green = 1;
                end

            end

            // ---------------------------------------------
            // NO PLATFORM AVAILABLE
            // ---------------------------------------------

            else begin

                e_green = 0;
                w_green = 0;

            end

        end

    end


    // =================================================
    // OUTPUT ASSIGNMENTS
    // =================================================

    assign E_P1 = e_p1;
    assign E_P2 = e_p2;
    assign E_P3 = e_p3;

    assign W_P1 = w_p1;
    assign W_P2 = w_p2;
    assign W_P3 = w_p3;

    assign E_GREEN = e_green;
    assign W_GREEN = w_green;

    // RED whenever GREEN is not active
    assign E_RED = ~E_GREEN;
    assign W_RED = ~W_GREEN;

endmodule