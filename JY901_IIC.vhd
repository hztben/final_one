-- JY901_IIC.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity JY901_IIC is
	port (
		wb_clk_i   : in    std_logic                     := '0';             --       avalon_slave_0_clock.clk
		wb_rst_i   : in    std_logic                     := '0';             -- avalon_slave_0_clock_reset.reset
		scl_pad_io : out   std_logic;                                        --      global_signals_export.export
		sda_pad_io : inout std_logic                     := '0';             --                           .export
		wb_ack_o   : out   std_logic;                                        --             avalon_slave_0.waitrequest_n
		wb_adr_i   : in    std_logic_vector(2 downto 0)  := (others => '0'); --                           .address
		wb_cs_i    : in    std_logic                     := '0';             --                           .chipselect
		wb_dat_i   : in    std_logic_vector(31 downto 0) := (others => '0'); --                           .writedata
		wb_dat_o   : out   std_logic_vector(31 downto 0);                    --                           .readdata
		wb_we_i    : in    std_logic                     := '0';             --                           .write
		wb_inta_o  : out   std_logic;                                        --         avalon_slave_0_irq.irq
		wb_err_o   : out   std_logic                                         --      avalon_slave_0_export.export
	);
end entity JY901_IIC;

architecture rtl of JY901_IIC is
	component opencores_i2c_master is
		port (
			wb_clk_i   : in    std_logic                     := 'X';             -- clk
			wb_rst_i   : in    std_logic                     := 'X';             -- reset
			scl_pad_io : out   std_logic;                                        -- export
			sda_pad_io : inout std_logic                     := 'X';             -- export
			wb_ack_o   : out   std_logic;                                        -- waitrequest_n
			wb_adr_i   : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			wb_cs_i    : in    std_logic                     := 'X';             -- chipselect
			wb_dat_i   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			wb_dat_o   : out   std_logic_vector(31 downto 0);                    -- readdata
			wb_we_i    : in    std_logic                     := 'X';             -- write
			wb_inta_o  : out   std_logic;                                        -- irq
			wb_err_o   : out   std_logic                                         -- export
		);
	end component opencores_i2c_master;

begin

	jy901_iic : component opencores_i2c_master
		port map (
			wb_clk_i   => wb_clk_i,   --       avalon_slave_0_clock.clk
			wb_rst_i   => wb_rst_i,   -- avalon_slave_0_clock_reset.reset
			scl_pad_io => scl_pad_io, --      global_signals_export.export
			sda_pad_io => sda_pad_io, --                           .export
			wb_ack_o   => wb_ack_o,   --             avalon_slave_0.waitrequest_n
			wb_adr_i   => wb_adr_i,   --                           .address
			wb_cs_i    => wb_cs_i,    --                           .chipselect
			wb_dat_i   => wb_dat_i,   --                           .writedata
			wb_dat_o   => wb_dat_o,   --                           .readdata
			wb_we_i    => wb_we_i,    --                           .write
			wb_inta_o  => wb_inta_o,  --         avalon_slave_0_irq.irq
			wb_err_o   => wb_err_o    --      avalon_slave_0_export.export
		);

end architecture rtl; -- of JY901_IIC
