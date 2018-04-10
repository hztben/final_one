--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2017 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity HC_12_s1_arbitrator is 
        port (
              -- inputs:
                 signal HC_12_s1_dataavailable : IN STD_LOGIC;
                 signal HC_12_s1_irq : IN STD_LOGIC;
                 signal HC_12_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal HC_12_s1_readyfordata : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal HC_12_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal HC_12_s1_begintransfer : OUT STD_LOGIC;
                 signal HC_12_s1_chipselect : OUT STD_LOGIC;
                 signal HC_12_s1_dataavailable_from_sa : OUT STD_LOGIC;
                 signal HC_12_s1_irq_from_sa : OUT STD_LOGIC;
                 signal HC_12_s1_read_n : OUT STD_LOGIC;
                 signal HC_12_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal HC_12_s1_readyfordata_from_sa : OUT STD_LOGIC;
                 signal HC_12_s1_reset_n : OUT STD_LOGIC;
                 signal HC_12_s1_write_n : OUT STD_LOGIC;
                 signal HC_12_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_0_data_master_granted_HC_12_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_HC_12_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_HC_12_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_HC_12_s1 : OUT STD_LOGIC;
                 signal d1_HC_12_s1_end_xfer : OUT STD_LOGIC
              );
end entity HC_12_s1_arbitrator;


architecture europa of HC_12_s1_arbitrator is
                signal HC_12_s1_allgrants :  STD_LOGIC;
                signal HC_12_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal HC_12_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal HC_12_s1_any_continuerequest :  STD_LOGIC;
                signal HC_12_s1_arb_counter_enable :  STD_LOGIC;
                signal HC_12_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal HC_12_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal HC_12_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal HC_12_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal HC_12_s1_begins_xfer :  STD_LOGIC;
                signal HC_12_s1_end_xfer :  STD_LOGIC;
                signal HC_12_s1_firsttransfer :  STD_LOGIC;
                signal HC_12_s1_grant_vector :  STD_LOGIC;
                signal HC_12_s1_in_a_read_cycle :  STD_LOGIC;
                signal HC_12_s1_in_a_write_cycle :  STD_LOGIC;
                signal HC_12_s1_master_qreq_vector :  STD_LOGIC;
                signal HC_12_s1_non_bursting_master_requests :  STD_LOGIC;
                signal HC_12_s1_reg_firsttransfer :  STD_LOGIC;
                signal HC_12_s1_slavearbiterlockenable :  STD_LOGIC;
                signal HC_12_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal HC_12_s1_unreg_firsttransfer :  STD_LOGIC;
                signal HC_12_s1_waits_for_read :  STD_LOGIC;
                signal HC_12_s1_waits_for_write :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_HC_12_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_HC_12_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_HC_12_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_HC_12_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_HC_12_s1 :  STD_LOGIC;
                signal shifted_address_to_HC_12_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_HC_12_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT HC_12_s1_end_xfer;
    end if;

  end process;

  HC_12_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_HC_12_s1);
  --assign HC_12_s1_readdata_from_sa = HC_12_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  HC_12_s1_readdata_from_sa <= HC_12_s1_readdata;
  internal_cpu_0_data_master_requests_HC_12_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("000000000000000000001000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign HC_12_s1_dataavailable_from_sa = HC_12_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  HC_12_s1_dataavailable_from_sa <= HC_12_s1_dataavailable;
  --assign HC_12_s1_readyfordata_from_sa = HC_12_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  HC_12_s1_readyfordata_from_sa <= HC_12_s1_readyfordata;
  --HC_12_s1_arb_share_counter set values, which is an e_mux
  HC_12_s1_arb_share_set_values <= std_logic_vector'("001");
  --HC_12_s1_non_bursting_master_requests mux, which is an e_mux
  HC_12_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_HC_12_s1;
  --HC_12_s1_any_bursting_master_saved_grant mux, which is an e_mux
  HC_12_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --HC_12_s1_arb_share_counter_next_value assignment, which is an e_assign
  HC_12_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(HC_12_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (HC_12_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(HC_12_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (HC_12_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --HC_12_s1_allgrants all slave grants, which is an e_mux
  HC_12_s1_allgrants <= HC_12_s1_grant_vector;
  --HC_12_s1_end_xfer assignment, which is an e_assign
  HC_12_s1_end_xfer <= NOT ((HC_12_s1_waits_for_read OR HC_12_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_HC_12_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_HC_12_s1 <= HC_12_s1_end_xfer AND (((NOT HC_12_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --HC_12_s1_arb_share_counter arbitration counter enable, which is an e_assign
  HC_12_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_HC_12_s1 AND HC_12_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_HC_12_s1 AND NOT HC_12_s1_non_bursting_master_requests));
  --HC_12_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HC_12_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(HC_12_s1_arb_counter_enable) = '1' then 
        HC_12_s1_arb_share_counter <= HC_12_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --HC_12_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HC_12_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((HC_12_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_HC_12_s1)) OR ((end_xfer_arb_share_counter_term_HC_12_s1 AND NOT HC_12_s1_non_bursting_master_requests)))) = '1' then 
        HC_12_s1_slavearbiterlockenable <= or_reduce(HC_12_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master HC_12/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= HC_12_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --HC_12_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  HC_12_s1_slavearbiterlockenable2 <= or_reduce(HC_12_s1_arb_share_counter_next_value);
  --cpu_0/data_master HC_12/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= HC_12_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --HC_12_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  HC_12_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_HC_12_s1 <= internal_cpu_0_data_master_requests_HC_12_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_HC_12_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_HC_12_s1 <= (internal_cpu_0_data_master_granted_HC_12_s1 AND cpu_0_data_master_read) AND NOT HC_12_s1_waits_for_read;
  --HC_12_s1_writedata mux, which is an e_mux
  HC_12_s1_writedata <= cpu_0_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_0_data_master_granted_HC_12_s1 <= internal_cpu_0_data_master_qualified_request_HC_12_s1;
  --cpu_0/data_master saved-grant HC_12/s1, which is an e_assign
  cpu_0_data_master_saved_grant_HC_12_s1 <= internal_cpu_0_data_master_requests_HC_12_s1;
  --allow new arb cycle for HC_12/s1, which is an e_assign
  HC_12_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  HC_12_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  HC_12_s1_master_qreq_vector <= std_logic'('1');
  HC_12_s1_begintransfer <= HC_12_s1_begins_xfer;
  --HC_12_s1_reset_n assignment, which is an e_assign
  HC_12_s1_reset_n <= reset_n;
  HC_12_s1_chipselect <= internal_cpu_0_data_master_granted_HC_12_s1;
  --HC_12_s1_firsttransfer first transaction, which is an e_assign
  HC_12_s1_firsttransfer <= A_WE_StdLogic((std_logic'(HC_12_s1_begins_xfer) = '1'), HC_12_s1_unreg_firsttransfer, HC_12_s1_reg_firsttransfer);
  --HC_12_s1_unreg_firsttransfer first transaction, which is an e_assign
  HC_12_s1_unreg_firsttransfer <= NOT ((HC_12_s1_slavearbiterlockenable AND HC_12_s1_any_continuerequest));
  --HC_12_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HC_12_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(HC_12_s1_begins_xfer) = '1' then 
        HC_12_s1_reg_firsttransfer <= HC_12_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --HC_12_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  HC_12_s1_beginbursttransfer_internal <= HC_12_s1_begins_xfer;
  --~HC_12_s1_read_n assignment, which is an e_mux
  HC_12_s1_read_n <= NOT ((internal_cpu_0_data_master_granted_HC_12_s1 AND cpu_0_data_master_read));
  --~HC_12_s1_write_n assignment, which is an e_mux
  HC_12_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_HC_12_s1 AND cpu_0_data_master_write));
  shifted_address_to_HC_12_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --HC_12_s1_address mux, which is an e_mux
  HC_12_s1_address <= A_EXT (A_SRL(shifted_address_to_HC_12_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_HC_12_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_HC_12_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_HC_12_s1_end_xfer <= HC_12_s1_end_xfer;
    end if;

  end process;

  --HC_12_s1_waits_for_read in a cycle, which is an e_mux
  HC_12_s1_waits_for_read <= HC_12_s1_in_a_read_cycle AND HC_12_s1_begins_xfer;
  --HC_12_s1_in_a_read_cycle assignment, which is an e_assign
  HC_12_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_HC_12_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= HC_12_s1_in_a_read_cycle;
  --HC_12_s1_waits_for_write in a cycle, which is an e_mux
  HC_12_s1_waits_for_write <= HC_12_s1_in_a_write_cycle AND HC_12_s1_begins_xfer;
  --HC_12_s1_in_a_write_cycle assignment, which is an e_assign
  HC_12_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_HC_12_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= HC_12_s1_in_a_write_cycle;
  wait_for_HC_12_s1_counter <= std_logic'('0');
  --assign HC_12_s1_irq_from_sa = HC_12_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  HC_12_s1_irq_from_sa <= HC_12_s1_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_HC_12_s1 <= internal_cpu_0_data_master_granted_HC_12_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_HC_12_s1 <= internal_cpu_0_data_master_qualified_request_HC_12_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_HC_12_s1 <= internal_cpu_0_data_master_requests_HC_12_s1;
--synthesis translate_off
    --HC_12/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity US_100_UART_s1_arbitrator is 
        port (
              -- inputs:
                 signal US_100_UART_s1_dataavailable : IN STD_LOGIC;
                 signal US_100_UART_s1_irq : IN STD_LOGIC;
                 signal US_100_UART_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal US_100_UART_s1_readyfordata : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal US_100_UART_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal US_100_UART_s1_begintransfer : OUT STD_LOGIC;
                 signal US_100_UART_s1_chipselect : OUT STD_LOGIC;
                 signal US_100_UART_s1_dataavailable_from_sa : OUT STD_LOGIC;
                 signal US_100_UART_s1_irq_from_sa : OUT STD_LOGIC;
                 signal US_100_UART_s1_read_n : OUT STD_LOGIC;
                 signal US_100_UART_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal US_100_UART_s1_readyfordata_from_sa : OUT STD_LOGIC;
                 signal US_100_UART_s1_reset_n : OUT STD_LOGIC;
                 signal US_100_UART_s1_write_n : OUT STD_LOGIC;
                 signal US_100_UART_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_0_data_master_granted_US_100_UART_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_US_100_UART_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_US_100_UART_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_US_100_UART_s1 : OUT STD_LOGIC;
                 signal d1_US_100_UART_s1_end_xfer : OUT STD_LOGIC
              );
end entity US_100_UART_s1_arbitrator;


architecture europa of US_100_UART_s1_arbitrator is
                signal US_100_UART_s1_allgrants :  STD_LOGIC;
                signal US_100_UART_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal US_100_UART_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal US_100_UART_s1_any_continuerequest :  STD_LOGIC;
                signal US_100_UART_s1_arb_counter_enable :  STD_LOGIC;
                signal US_100_UART_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal US_100_UART_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal US_100_UART_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal US_100_UART_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal US_100_UART_s1_begins_xfer :  STD_LOGIC;
                signal US_100_UART_s1_end_xfer :  STD_LOGIC;
                signal US_100_UART_s1_firsttransfer :  STD_LOGIC;
                signal US_100_UART_s1_grant_vector :  STD_LOGIC;
                signal US_100_UART_s1_in_a_read_cycle :  STD_LOGIC;
                signal US_100_UART_s1_in_a_write_cycle :  STD_LOGIC;
                signal US_100_UART_s1_master_qreq_vector :  STD_LOGIC;
                signal US_100_UART_s1_non_bursting_master_requests :  STD_LOGIC;
                signal US_100_UART_s1_reg_firsttransfer :  STD_LOGIC;
                signal US_100_UART_s1_slavearbiterlockenable :  STD_LOGIC;
                signal US_100_UART_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal US_100_UART_s1_unreg_firsttransfer :  STD_LOGIC;
                signal US_100_UART_s1_waits_for_read :  STD_LOGIC;
                signal US_100_UART_s1_waits_for_write :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_US_100_UART_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_US_100_UART_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_US_100_UART_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_US_100_UART_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_US_100_UART_s1 :  STD_LOGIC;
                signal shifted_address_to_US_100_UART_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_US_100_UART_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT US_100_UART_s1_end_xfer;
    end if;

  end process;

  US_100_UART_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_US_100_UART_s1);
  --assign US_100_UART_s1_readdata_from_sa = US_100_UART_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  US_100_UART_s1_readdata_from_sa <= US_100_UART_s1_readdata;
  internal_cpu_0_data_master_requests_US_100_UART_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("000000000000000000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign US_100_UART_s1_dataavailable_from_sa = US_100_UART_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  US_100_UART_s1_dataavailable_from_sa <= US_100_UART_s1_dataavailable;
  --assign US_100_UART_s1_readyfordata_from_sa = US_100_UART_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  US_100_UART_s1_readyfordata_from_sa <= US_100_UART_s1_readyfordata;
  --US_100_UART_s1_arb_share_counter set values, which is an e_mux
  US_100_UART_s1_arb_share_set_values <= std_logic_vector'("001");
  --US_100_UART_s1_non_bursting_master_requests mux, which is an e_mux
  US_100_UART_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_US_100_UART_s1;
  --US_100_UART_s1_any_bursting_master_saved_grant mux, which is an e_mux
  US_100_UART_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --US_100_UART_s1_arb_share_counter_next_value assignment, which is an e_assign
  US_100_UART_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(US_100_UART_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (US_100_UART_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(US_100_UART_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (US_100_UART_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --US_100_UART_s1_allgrants all slave grants, which is an e_mux
  US_100_UART_s1_allgrants <= US_100_UART_s1_grant_vector;
  --US_100_UART_s1_end_xfer assignment, which is an e_assign
  US_100_UART_s1_end_xfer <= NOT ((US_100_UART_s1_waits_for_read OR US_100_UART_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_US_100_UART_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_US_100_UART_s1 <= US_100_UART_s1_end_xfer AND (((NOT US_100_UART_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --US_100_UART_s1_arb_share_counter arbitration counter enable, which is an e_assign
  US_100_UART_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_US_100_UART_s1 AND US_100_UART_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_US_100_UART_s1 AND NOT US_100_UART_s1_non_bursting_master_requests));
  --US_100_UART_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      US_100_UART_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(US_100_UART_s1_arb_counter_enable) = '1' then 
        US_100_UART_s1_arb_share_counter <= US_100_UART_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --US_100_UART_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      US_100_UART_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((US_100_UART_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_US_100_UART_s1)) OR ((end_xfer_arb_share_counter_term_US_100_UART_s1 AND NOT US_100_UART_s1_non_bursting_master_requests)))) = '1' then 
        US_100_UART_s1_slavearbiterlockenable <= or_reduce(US_100_UART_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master US_100_UART/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= US_100_UART_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --US_100_UART_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  US_100_UART_s1_slavearbiterlockenable2 <= or_reduce(US_100_UART_s1_arb_share_counter_next_value);
  --cpu_0/data_master US_100_UART/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= US_100_UART_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --US_100_UART_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  US_100_UART_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_US_100_UART_s1 <= internal_cpu_0_data_master_requests_US_100_UART_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_US_100_UART_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_US_100_UART_s1 <= (internal_cpu_0_data_master_granted_US_100_UART_s1 AND cpu_0_data_master_read) AND NOT US_100_UART_s1_waits_for_read;
  --US_100_UART_s1_writedata mux, which is an e_mux
  US_100_UART_s1_writedata <= cpu_0_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_0_data_master_granted_US_100_UART_s1 <= internal_cpu_0_data_master_qualified_request_US_100_UART_s1;
  --cpu_0/data_master saved-grant US_100_UART/s1, which is an e_assign
  cpu_0_data_master_saved_grant_US_100_UART_s1 <= internal_cpu_0_data_master_requests_US_100_UART_s1;
  --allow new arb cycle for US_100_UART/s1, which is an e_assign
  US_100_UART_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  US_100_UART_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  US_100_UART_s1_master_qreq_vector <= std_logic'('1');
  US_100_UART_s1_begintransfer <= US_100_UART_s1_begins_xfer;
  --US_100_UART_s1_reset_n assignment, which is an e_assign
  US_100_UART_s1_reset_n <= reset_n;
  US_100_UART_s1_chipselect <= internal_cpu_0_data_master_granted_US_100_UART_s1;
  --US_100_UART_s1_firsttransfer first transaction, which is an e_assign
  US_100_UART_s1_firsttransfer <= A_WE_StdLogic((std_logic'(US_100_UART_s1_begins_xfer) = '1'), US_100_UART_s1_unreg_firsttransfer, US_100_UART_s1_reg_firsttransfer);
  --US_100_UART_s1_unreg_firsttransfer first transaction, which is an e_assign
  US_100_UART_s1_unreg_firsttransfer <= NOT ((US_100_UART_s1_slavearbiterlockenable AND US_100_UART_s1_any_continuerequest));
  --US_100_UART_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      US_100_UART_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(US_100_UART_s1_begins_xfer) = '1' then 
        US_100_UART_s1_reg_firsttransfer <= US_100_UART_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --US_100_UART_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  US_100_UART_s1_beginbursttransfer_internal <= US_100_UART_s1_begins_xfer;
  --~US_100_UART_s1_read_n assignment, which is an e_mux
  US_100_UART_s1_read_n <= NOT ((internal_cpu_0_data_master_granted_US_100_UART_s1 AND cpu_0_data_master_read));
  --~US_100_UART_s1_write_n assignment, which is an e_mux
  US_100_UART_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_US_100_UART_s1 AND cpu_0_data_master_write));
  shifted_address_to_US_100_UART_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --US_100_UART_s1_address mux, which is an e_mux
  US_100_UART_s1_address <= A_EXT (A_SRL(shifted_address_to_US_100_UART_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_US_100_UART_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_US_100_UART_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_US_100_UART_s1_end_xfer <= US_100_UART_s1_end_xfer;
    end if;

  end process;

  --US_100_UART_s1_waits_for_read in a cycle, which is an e_mux
  US_100_UART_s1_waits_for_read <= US_100_UART_s1_in_a_read_cycle AND US_100_UART_s1_begins_xfer;
  --US_100_UART_s1_in_a_read_cycle assignment, which is an e_assign
  US_100_UART_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_US_100_UART_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= US_100_UART_s1_in_a_read_cycle;
  --US_100_UART_s1_waits_for_write in a cycle, which is an e_mux
  US_100_UART_s1_waits_for_write <= US_100_UART_s1_in_a_write_cycle AND US_100_UART_s1_begins_xfer;
  --US_100_UART_s1_in_a_write_cycle assignment, which is an e_assign
  US_100_UART_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_US_100_UART_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= US_100_UART_s1_in_a_write_cycle;
  wait_for_US_100_UART_s1_counter <= std_logic'('0');
  --assign US_100_UART_s1_irq_from_sa = US_100_UART_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  US_100_UART_s1_irq_from_sa <= US_100_UART_s1_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_US_100_UART_s1 <= internal_cpu_0_data_master_granted_US_100_UART_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_US_100_UART_s1 <= internal_cpu_0_data_master_qualified_request_US_100_UART_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_US_100_UART_s1 <= internal_cpu_0_data_master_requests_US_100_UART_s1;
--synthesis translate_off
    --US_100_UART/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity addr_s1_arbitrator is 
        port (
              -- inputs:
                 signal addr_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal addr_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal addr_s1_chipselect : OUT STD_LOGIC;
                 signal addr_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal addr_s1_reset_n : OUT STD_LOGIC;
                 signal addr_s1_write_n : OUT STD_LOGIC;
                 signal addr_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_granted_addr_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_addr_s1 : OUT STD_LOGIC;
                 signal d1_addr_s1_end_xfer : OUT STD_LOGIC
              );
end entity addr_s1_arbitrator;


architecture europa of addr_s1_arbitrator is
                signal addr_s1_allgrants :  STD_LOGIC;
                signal addr_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal addr_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal addr_s1_any_continuerequest :  STD_LOGIC;
                signal addr_s1_arb_counter_enable :  STD_LOGIC;
                signal addr_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal addr_s1_begins_xfer :  STD_LOGIC;
                signal addr_s1_end_xfer :  STD_LOGIC;
                signal addr_s1_firsttransfer :  STD_LOGIC;
                signal addr_s1_grant_vector :  STD_LOGIC;
                signal addr_s1_in_a_read_cycle :  STD_LOGIC;
                signal addr_s1_in_a_write_cycle :  STD_LOGIC;
                signal addr_s1_master_qreq_vector :  STD_LOGIC;
                signal addr_s1_non_bursting_master_requests :  STD_LOGIC;
                signal addr_s1_reg_firsttransfer :  STD_LOGIC;
                signal addr_s1_slavearbiterlockenable :  STD_LOGIC;
                signal addr_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal addr_s1_unreg_firsttransfer :  STD_LOGIC;
                signal addr_s1_waits_for_read :  STD_LOGIC;
                signal addr_s1_waits_for_write :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_addr_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_addr_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_addr_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_addr_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_addr_s1 :  STD_LOGIC;
                signal shifted_address_to_addr_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_addr_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT addr_s1_end_xfer;
    end if;

  end process;

  addr_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_addr_s1);
  --assign addr_s1_readdata_from_sa = addr_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  addr_s1_readdata_from_sa <= addr_s1_readdata;
  internal_cpu_0_data_master_requests_addr_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000001010000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --addr_s1_arb_share_counter set values, which is an e_mux
  addr_s1_arb_share_set_values <= std_logic_vector'("001");
  --addr_s1_non_bursting_master_requests mux, which is an e_mux
  addr_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_addr_s1;
  --addr_s1_any_bursting_master_saved_grant mux, which is an e_mux
  addr_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --addr_s1_arb_share_counter_next_value assignment, which is an e_assign
  addr_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(addr_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(addr_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --addr_s1_allgrants all slave grants, which is an e_mux
  addr_s1_allgrants <= addr_s1_grant_vector;
  --addr_s1_end_xfer assignment, which is an e_assign
  addr_s1_end_xfer <= NOT ((addr_s1_waits_for_read OR addr_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_addr_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_addr_s1 <= addr_s1_end_xfer AND (((NOT addr_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --addr_s1_arb_share_counter arbitration counter enable, which is an e_assign
  addr_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_addr_s1 AND addr_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_addr_s1 AND NOT addr_s1_non_bursting_master_requests));
  --addr_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(addr_s1_arb_counter_enable) = '1' then 
        addr_s1_arb_share_counter <= addr_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --addr_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((addr_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_addr_s1)) OR ((end_xfer_arb_share_counter_term_addr_s1 AND NOT addr_s1_non_bursting_master_requests)))) = '1' then 
        addr_s1_slavearbiterlockenable <= or_reduce(addr_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master addr/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= addr_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --addr_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  addr_s1_slavearbiterlockenable2 <= or_reduce(addr_s1_arb_share_counter_next_value);
  --cpu_0/data_master addr/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= addr_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --addr_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  addr_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_addr_s1 <= internal_cpu_0_data_master_requests_addr_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_addr_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_addr_s1 <= (internal_cpu_0_data_master_granted_addr_s1 AND cpu_0_data_master_read) AND NOT addr_s1_waits_for_read;
  --addr_s1_writedata mux, which is an e_mux
  addr_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_addr_s1 <= internal_cpu_0_data_master_qualified_request_addr_s1;
  --cpu_0/data_master saved-grant addr/s1, which is an e_assign
  cpu_0_data_master_saved_grant_addr_s1 <= internal_cpu_0_data_master_requests_addr_s1;
  --allow new arb cycle for addr/s1, which is an e_assign
  addr_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  addr_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  addr_s1_master_qreq_vector <= std_logic'('1');
  --addr_s1_reset_n assignment, which is an e_assign
  addr_s1_reset_n <= reset_n;
  addr_s1_chipselect <= internal_cpu_0_data_master_granted_addr_s1;
  --addr_s1_firsttransfer first transaction, which is an e_assign
  addr_s1_firsttransfer <= A_WE_StdLogic((std_logic'(addr_s1_begins_xfer) = '1'), addr_s1_unreg_firsttransfer, addr_s1_reg_firsttransfer);
  --addr_s1_unreg_firsttransfer first transaction, which is an e_assign
  addr_s1_unreg_firsttransfer <= NOT ((addr_s1_slavearbiterlockenable AND addr_s1_any_continuerequest));
  --addr_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(addr_s1_begins_xfer) = '1' then 
        addr_s1_reg_firsttransfer <= addr_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --addr_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  addr_s1_beginbursttransfer_internal <= addr_s1_begins_xfer;
  --~addr_s1_write_n assignment, which is an e_mux
  addr_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_addr_s1 AND cpu_0_data_master_write));
  shifted_address_to_addr_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --addr_s1_address mux, which is an e_mux
  addr_s1_address <= A_EXT (A_SRL(shifted_address_to_addr_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_addr_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_addr_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_addr_s1_end_xfer <= addr_s1_end_xfer;
    end if;

  end process;

  --addr_s1_waits_for_read in a cycle, which is an e_mux
  addr_s1_waits_for_read <= addr_s1_in_a_read_cycle AND addr_s1_begins_xfer;
  --addr_s1_in_a_read_cycle assignment, which is an e_assign
  addr_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_addr_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= addr_s1_in_a_read_cycle;
  --addr_s1_waits_for_write in a cycle, which is an e_mux
  addr_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(addr_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --addr_s1_in_a_write_cycle assignment, which is an e_assign
  addr_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_addr_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= addr_s1_in_a_write_cycle;
  wait_for_addr_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_addr_s1 <= internal_cpu_0_data_master_granted_addr_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_addr_s1 <= internal_cpu_0_data_master_qualified_request_addr_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_addr_s1 <= internal_cpu_0_data_master_requests_addr_s1;
--synthesis translate_off
    --addr/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity addr2_s1_arbitrator is 
        port (
              -- inputs:
                 signal addr2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal addr2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal addr2_s1_chipselect : OUT STD_LOGIC;
                 signal addr2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal addr2_s1_reset_n : OUT STD_LOGIC;
                 signal addr2_s1_write_n : OUT STD_LOGIC;
                 signal addr2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_granted_addr2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_addr2_s1 : OUT STD_LOGIC;
                 signal d1_addr2_s1_end_xfer : OUT STD_LOGIC
              );
end entity addr2_s1_arbitrator;


architecture europa of addr2_s1_arbitrator is
                signal addr2_s1_allgrants :  STD_LOGIC;
                signal addr2_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal addr2_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal addr2_s1_any_continuerequest :  STD_LOGIC;
                signal addr2_s1_arb_counter_enable :  STD_LOGIC;
                signal addr2_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr2_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr2_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr2_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal addr2_s1_begins_xfer :  STD_LOGIC;
                signal addr2_s1_end_xfer :  STD_LOGIC;
                signal addr2_s1_firsttransfer :  STD_LOGIC;
                signal addr2_s1_grant_vector :  STD_LOGIC;
                signal addr2_s1_in_a_read_cycle :  STD_LOGIC;
                signal addr2_s1_in_a_write_cycle :  STD_LOGIC;
                signal addr2_s1_master_qreq_vector :  STD_LOGIC;
                signal addr2_s1_non_bursting_master_requests :  STD_LOGIC;
                signal addr2_s1_reg_firsttransfer :  STD_LOGIC;
                signal addr2_s1_slavearbiterlockenable :  STD_LOGIC;
                signal addr2_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal addr2_s1_unreg_firsttransfer :  STD_LOGIC;
                signal addr2_s1_waits_for_read :  STD_LOGIC;
                signal addr2_s1_waits_for_write :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_addr2_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_addr2_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_addr2_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_addr2_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_addr2_s1 :  STD_LOGIC;
                signal shifted_address_to_addr2_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_addr2_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT addr2_s1_end_xfer;
    end if;

  end process;

  addr2_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_addr2_s1);
  --assign addr2_s1_readdata_from_sa = addr2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  addr2_s1_readdata_from_sa <= addr2_s1_readdata;
  internal_cpu_0_data_master_requests_addr2_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000010010000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --addr2_s1_arb_share_counter set values, which is an e_mux
  addr2_s1_arb_share_set_values <= std_logic_vector'("001");
  --addr2_s1_non_bursting_master_requests mux, which is an e_mux
  addr2_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_addr2_s1;
  --addr2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  addr2_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --addr2_s1_arb_share_counter_next_value assignment, which is an e_assign
  addr2_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(addr2_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr2_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(addr2_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr2_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --addr2_s1_allgrants all slave grants, which is an e_mux
  addr2_s1_allgrants <= addr2_s1_grant_vector;
  --addr2_s1_end_xfer assignment, which is an e_assign
  addr2_s1_end_xfer <= NOT ((addr2_s1_waits_for_read OR addr2_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_addr2_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_addr2_s1 <= addr2_s1_end_xfer AND (((NOT addr2_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --addr2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  addr2_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_addr2_s1 AND addr2_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_addr2_s1 AND NOT addr2_s1_non_bursting_master_requests));
  --addr2_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr2_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(addr2_s1_arb_counter_enable) = '1' then 
        addr2_s1_arb_share_counter <= addr2_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --addr2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr2_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((addr2_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_addr2_s1)) OR ((end_xfer_arb_share_counter_term_addr2_s1 AND NOT addr2_s1_non_bursting_master_requests)))) = '1' then 
        addr2_s1_slavearbiterlockenable <= or_reduce(addr2_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master addr2/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= addr2_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --addr2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  addr2_s1_slavearbiterlockenable2 <= or_reduce(addr2_s1_arb_share_counter_next_value);
  --cpu_0/data_master addr2/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= addr2_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --addr2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  addr2_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_addr2_s1 <= internal_cpu_0_data_master_requests_addr2_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_addr2_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_addr2_s1 <= (internal_cpu_0_data_master_granted_addr2_s1 AND cpu_0_data_master_read) AND NOT addr2_s1_waits_for_read;
  --addr2_s1_writedata mux, which is an e_mux
  addr2_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_addr2_s1 <= internal_cpu_0_data_master_qualified_request_addr2_s1;
  --cpu_0/data_master saved-grant addr2/s1, which is an e_assign
  cpu_0_data_master_saved_grant_addr2_s1 <= internal_cpu_0_data_master_requests_addr2_s1;
  --allow new arb cycle for addr2/s1, which is an e_assign
  addr2_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  addr2_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  addr2_s1_master_qreq_vector <= std_logic'('1');
  --addr2_s1_reset_n assignment, which is an e_assign
  addr2_s1_reset_n <= reset_n;
  addr2_s1_chipselect <= internal_cpu_0_data_master_granted_addr2_s1;
  --addr2_s1_firsttransfer first transaction, which is an e_assign
  addr2_s1_firsttransfer <= A_WE_StdLogic((std_logic'(addr2_s1_begins_xfer) = '1'), addr2_s1_unreg_firsttransfer, addr2_s1_reg_firsttransfer);
  --addr2_s1_unreg_firsttransfer first transaction, which is an e_assign
  addr2_s1_unreg_firsttransfer <= NOT ((addr2_s1_slavearbiterlockenable AND addr2_s1_any_continuerequest));
  --addr2_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr2_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(addr2_s1_begins_xfer) = '1' then 
        addr2_s1_reg_firsttransfer <= addr2_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --addr2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  addr2_s1_beginbursttransfer_internal <= addr2_s1_begins_xfer;
  --~addr2_s1_write_n assignment, which is an e_mux
  addr2_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_addr2_s1 AND cpu_0_data_master_write));
  shifted_address_to_addr2_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --addr2_s1_address mux, which is an e_mux
  addr2_s1_address <= A_EXT (A_SRL(shifted_address_to_addr2_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_addr2_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_addr2_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_addr2_s1_end_xfer <= addr2_s1_end_xfer;
    end if;

  end process;

  --addr2_s1_waits_for_read in a cycle, which is an e_mux
  addr2_s1_waits_for_read <= addr2_s1_in_a_read_cycle AND addr2_s1_begins_xfer;
  --addr2_s1_in_a_read_cycle assignment, which is an e_assign
  addr2_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_addr2_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= addr2_s1_in_a_read_cycle;
  --addr2_s1_waits_for_write in a cycle, which is an e_mux
  addr2_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(addr2_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --addr2_s1_in_a_write_cycle assignment, which is an e_assign
  addr2_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_addr2_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= addr2_s1_in_a_write_cycle;
  wait_for_addr2_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_addr2_s1 <= internal_cpu_0_data_master_granted_addr2_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_addr2_s1 <= internal_cpu_0_data_master_qualified_request_addr2_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_addr2_s1 <= internal_cpu_0_data_master_requests_addr2_s1;
--synthesis translate_off
    --addr2/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity addr3_s1_arbitrator is 
        port (
              -- inputs:
                 signal addr3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal addr3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal addr3_s1_chipselect : OUT STD_LOGIC;
                 signal addr3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal addr3_s1_reset_n : OUT STD_LOGIC;
                 signal addr3_s1_write_n : OUT STD_LOGIC;
                 signal addr3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_granted_addr3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_addr3_s1 : OUT STD_LOGIC;
                 signal d1_addr3_s1_end_xfer : OUT STD_LOGIC
              );
end entity addr3_s1_arbitrator;


architecture europa of addr3_s1_arbitrator is
                signal addr3_s1_allgrants :  STD_LOGIC;
                signal addr3_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal addr3_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal addr3_s1_any_continuerequest :  STD_LOGIC;
                signal addr3_s1_arb_counter_enable :  STD_LOGIC;
                signal addr3_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr3_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr3_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr3_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal addr3_s1_begins_xfer :  STD_LOGIC;
                signal addr3_s1_end_xfer :  STD_LOGIC;
                signal addr3_s1_firsttransfer :  STD_LOGIC;
                signal addr3_s1_grant_vector :  STD_LOGIC;
                signal addr3_s1_in_a_read_cycle :  STD_LOGIC;
                signal addr3_s1_in_a_write_cycle :  STD_LOGIC;
                signal addr3_s1_master_qreq_vector :  STD_LOGIC;
                signal addr3_s1_non_bursting_master_requests :  STD_LOGIC;
                signal addr3_s1_reg_firsttransfer :  STD_LOGIC;
                signal addr3_s1_slavearbiterlockenable :  STD_LOGIC;
                signal addr3_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal addr3_s1_unreg_firsttransfer :  STD_LOGIC;
                signal addr3_s1_waits_for_read :  STD_LOGIC;
                signal addr3_s1_waits_for_write :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_addr3_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_addr3_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_addr3_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_addr3_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_addr3_s1 :  STD_LOGIC;
                signal shifted_address_to_addr3_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_addr3_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT addr3_s1_end_xfer;
    end if;

  end process;

  addr3_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_addr3_s1);
  --assign addr3_s1_readdata_from_sa = addr3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  addr3_s1_readdata_from_sa <= addr3_s1_readdata;
  internal_cpu_0_data_master_requests_addr3_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000010100000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --addr3_s1_arb_share_counter set values, which is an e_mux
  addr3_s1_arb_share_set_values <= std_logic_vector'("001");
  --addr3_s1_non_bursting_master_requests mux, which is an e_mux
  addr3_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_addr3_s1;
  --addr3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  addr3_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --addr3_s1_arb_share_counter_next_value assignment, which is an e_assign
  addr3_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(addr3_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr3_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(addr3_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr3_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --addr3_s1_allgrants all slave grants, which is an e_mux
  addr3_s1_allgrants <= addr3_s1_grant_vector;
  --addr3_s1_end_xfer assignment, which is an e_assign
  addr3_s1_end_xfer <= NOT ((addr3_s1_waits_for_read OR addr3_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_addr3_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_addr3_s1 <= addr3_s1_end_xfer AND (((NOT addr3_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --addr3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  addr3_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_addr3_s1 AND addr3_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_addr3_s1 AND NOT addr3_s1_non_bursting_master_requests));
  --addr3_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr3_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(addr3_s1_arb_counter_enable) = '1' then 
        addr3_s1_arb_share_counter <= addr3_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --addr3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr3_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((addr3_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_addr3_s1)) OR ((end_xfer_arb_share_counter_term_addr3_s1 AND NOT addr3_s1_non_bursting_master_requests)))) = '1' then 
        addr3_s1_slavearbiterlockenable <= or_reduce(addr3_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master addr3/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= addr3_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --addr3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  addr3_s1_slavearbiterlockenable2 <= or_reduce(addr3_s1_arb_share_counter_next_value);
  --cpu_0/data_master addr3/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= addr3_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --addr3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  addr3_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_addr3_s1 <= internal_cpu_0_data_master_requests_addr3_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_addr3_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_addr3_s1 <= (internal_cpu_0_data_master_granted_addr3_s1 AND cpu_0_data_master_read) AND NOT addr3_s1_waits_for_read;
  --addr3_s1_writedata mux, which is an e_mux
  addr3_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_addr3_s1 <= internal_cpu_0_data_master_qualified_request_addr3_s1;
  --cpu_0/data_master saved-grant addr3/s1, which is an e_assign
  cpu_0_data_master_saved_grant_addr3_s1 <= internal_cpu_0_data_master_requests_addr3_s1;
  --allow new arb cycle for addr3/s1, which is an e_assign
  addr3_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  addr3_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  addr3_s1_master_qreq_vector <= std_logic'('1');
  --addr3_s1_reset_n assignment, which is an e_assign
  addr3_s1_reset_n <= reset_n;
  addr3_s1_chipselect <= internal_cpu_0_data_master_granted_addr3_s1;
  --addr3_s1_firsttransfer first transaction, which is an e_assign
  addr3_s1_firsttransfer <= A_WE_StdLogic((std_logic'(addr3_s1_begins_xfer) = '1'), addr3_s1_unreg_firsttransfer, addr3_s1_reg_firsttransfer);
  --addr3_s1_unreg_firsttransfer first transaction, which is an e_assign
  addr3_s1_unreg_firsttransfer <= NOT ((addr3_s1_slavearbiterlockenable AND addr3_s1_any_continuerequest));
  --addr3_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr3_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(addr3_s1_begins_xfer) = '1' then 
        addr3_s1_reg_firsttransfer <= addr3_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --addr3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  addr3_s1_beginbursttransfer_internal <= addr3_s1_begins_xfer;
  --~addr3_s1_write_n assignment, which is an e_mux
  addr3_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_addr3_s1 AND cpu_0_data_master_write));
  shifted_address_to_addr3_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --addr3_s1_address mux, which is an e_mux
  addr3_s1_address <= A_EXT (A_SRL(shifted_address_to_addr3_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_addr3_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_addr3_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_addr3_s1_end_xfer <= addr3_s1_end_xfer;
    end if;

  end process;

  --addr3_s1_waits_for_read in a cycle, which is an e_mux
  addr3_s1_waits_for_read <= addr3_s1_in_a_read_cycle AND addr3_s1_begins_xfer;
  --addr3_s1_in_a_read_cycle assignment, which is an e_assign
  addr3_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_addr3_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= addr3_s1_in_a_read_cycle;
  --addr3_s1_waits_for_write in a cycle, which is an e_mux
  addr3_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(addr3_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --addr3_s1_in_a_write_cycle assignment, which is an e_assign
  addr3_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_addr3_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= addr3_s1_in_a_write_cycle;
  wait_for_addr3_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_addr3_s1 <= internal_cpu_0_data_master_granted_addr3_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_addr3_s1 <= internal_cpu_0_data_master_qualified_request_addr3_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_addr3_s1 <= internal_cpu_0_data_master_requests_addr3_s1;
--synthesis translate_off
    --addr3/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity addr4_s1_arbitrator is 
        port (
              -- inputs:
                 signal addr4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal addr4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal addr4_s1_chipselect : OUT STD_LOGIC;
                 signal addr4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal addr4_s1_reset_n : OUT STD_LOGIC;
                 signal addr4_s1_write_n : OUT STD_LOGIC;
                 signal addr4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_granted_addr4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_addr4_s1 : OUT STD_LOGIC;
                 signal d1_addr4_s1_end_xfer : OUT STD_LOGIC
              );
end entity addr4_s1_arbitrator;


architecture europa of addr4_s1_arbitrator is
                signal addr4_s1_allgrants :  STD_LOGIC;
                signal addr4_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal addr4_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal addr4_s1_any_continuerequest :  STD_LOGIC;
                signal addr4_s1_arb_counter_enable :  STD_LOGIC;
                signal addr4_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr4_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr4_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal addr4_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal addr4_s1_begins_xfer :  STD_LOGIC;
                signal addr4_s1_end_xfer :  STD_LOGIC;
                signal addr4_s1_firsttransfer :  STD_LOGIC;
                signal addr4_s1_grant_vector :  STD_LOGIC;
                signal addr4_s1_in_a_read_cycle :  STD_LOGIC;
                signal addr4_s1_in_a_write_cycle :  STD_LOGIC;
                signal addr4_s1_master_qreq_vector :  STD_LOGIC;
                signal addr4_s1_non_bursting_master_requests :  STD_LOGIC;
                signal addr4_s1_reg_firsttransfer :  STD_LOGIC;
                signal addr4_s1_slavearbiterlockenable :  STD_LOGIC;
                signal addr4_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal addr4_s1_unreg_firsttransfer :  STD_LOGIC;
                signal addr4_s1_waits_for_read :  STD_LOGIC;
                signal addr4_s1_waits_for_write :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_addr4_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_addr4_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_addr4_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_addr4_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_addr4_s1 :  STD_LOGIC;
                signal shifted_address_to_addr4_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_addr4_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT addr4_s1_end_xfer;
    end if;

  end process;

  addr4_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_addr4_s1);
  --assign addr4_s1_readdata_from_sa = addr4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  addr4_s1_readdata_from_sa <= addr4_s1_readdata;
  internal_cpu_0_data_master_requests_addr4_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000010110000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --addr4_s1_arb_share_counter set values, which is an e_mux
  addr4_s1_arb_share_set_values <= std_logic_vector'("001");
  --addr4_s1_non_bursting_master_requests mux, which is an e_mux
  addr4_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_addr4_s1;
  --addr4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  addr4_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --addr4_s1_arb_share_counter_next_value assignment, which is an e_assign
  addr4_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(addr4_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr4_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(addr4_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (addr4_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --addr4_s1_allgrants all slave grants, which is an e_mux
  addr4_s1_allgrants <= addr4_s1_grant_vector;
  --addr4_s1_end_xfer assignment, which is an e_assign
  addr4_s1_end_xfer <= NOT ((addr4_s1_waits_for_read OR addr4_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_addr4_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_addr4_s1 <= addr4_s1_end_xfer AND (((NOT addr4_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --addr4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  addr4_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_addr4_s1 AND addr4_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_addr4_s1 AND NOT addr4_s1_non_bursting_master_requests));
  --addr4_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr4_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(addr4_s1_arb_counter_enable) = '1' then 
        addr4_s1_arb_share_counter <= addr4_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --addr4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr4_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((addr4_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_addr4_s1)) OR ((end_xfer_arb_share_counter_term_addr4_s1 AND NOT addr4_s1_non_bursting_master_requests)))) = '1' then 
        addr4_s1_slavearbiterlockenable <= or_reduce(addr4_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master addr4/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= addr4_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --addr4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  addr4_s1_slavearbiterlockenable2 <= or_reduce(addr4_s1_arb_share_counter_next_value);
  --cpu_0/data_master addr4/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= addr4_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --addr4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  addr4_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_addr4_s1 <= internal_cpu_0_data_master_requests_addr4_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_addr4_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_addr4_s1 <= (internal_cpu_0_data_master_granted_addr4_s1 AND cpu_0_data_master_read) AND NOT addr4_s1_waits_for_read;
  --addr4_s1_writedata mux, which is an e_mux
  addr4_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_addr4_s1 <= internal_cpu_0_data_master_qualified_request_addr4_s1;
  --cpu_0/data_master saved-grant addr4/s1, which is an e_assign
  cpu_0_data_master_saved_grant_addr4_s1 <= internal_cpu_0_data_master_requests_addr4_s1;
  --allow new arb cycle for addr4/s1, which is an e_assign
  addr4_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  addr4_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  addr4_s1_master_qreq_vector <= std_logic'('1');
  --addr4_s1_reset_n assignment, which is an e_assign
  addr4_s1_reset_n <= reset_n;
  addr4_s1_chipselect <= internal_cpu_0_data_master_granted_addr4_s1;
  --addr4_s1_firsttransfer first transaction, which is an e_assign
  addr4_s1_firsttransfer <= A_WE_StdLogic((std_logic'(addr4_s1_begins_xfer) = '1'), addr4_s1_unreg_firsttransfer, addr4_s1_reg_firsttransfer);
  --addr4_s1_unreg_firsttransfer first transaction, which is an e_assign
  addr4_s1_unreg_firsttransfer <= NOT ((addr4_s1_slavearbiterlockenable AND addr4_s1_any_continuerequest));
  --addr4_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      addr4_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(addr4_s1_begins_xfer) = '1' then 
        addr4_s1_reg_firsttransfer <= addr4_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --addr4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  addr4_s1_beginbursttransfer_internal <= addr4_s1_begins_xfer;
  --~addr4_s1_write_n assignment, which is an e_mux
  addr4_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_addr4_s1 AND cpu_0_data_master_write));
  shifted_address_to_addr4_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --addr4_s1_address mux, which is an e_mux
  addr4_s1_address <= A_EXT (A_SRL(shifted_address_to_addr4_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_addr4_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_addr4_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_addr4_s1_end_xfer <= addr4_s1_end_xfer;
    end if;

  end process;

  --addr4_s1_waits_for_read in a cycle, which is an e_mux
  addr4_s1_waits_for_read <= addr4_s1_in_a_read_cycle AND addr4_s1_begins_xfer;
  --addr4_s1_in_a_read_cycle assignment, which is an e_assign
  addr4_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_addr4_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= addr4_s1_in_a_read_cycle;
  --addr4_s1_waits_for_write in a cycle, which is an e_mux
  addr4_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(addr4_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --addr4_s1_in_a_write_cycle assignment, which is an e_assign
  addr4_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_addr4_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= addr4_s1_in_a_write_cycle;
  wait_for_addr4_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_addr4_s1 <= internal_cpu_0_data_master_granted_addr4_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_addr4_s1 <= internal_cpu_0_data_master_qualified_request_addr4_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_addr4_s1 <= internal_cpu_0_data_master_requests_addr4_s1;
--synthesis translate_off
    --addr4/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_0_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_debugaccess : IN STD_LOGIC;
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_reset_n : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_write : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_0_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
end entity cpu_0_jtag_debug_module_arbitrator;


architecture europa of cpu_0_jtag_debug_module_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_allgrants :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_cpu_0_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT cpu_0_jtag_debug_module_end_xfer;
    end if;

  end process;

  cpu_0_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  --assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_0_jtag_debug_module_readdata_from_sa <= cpu_0_jtag_debug_module_readdata;
  internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000010000001000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  cpu_0_jtag_debug_module_arb_share_set_values <= std_logic_vector'("001");
  --cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  cpu_0_jtag_debug_module_non_bursting_master_requests <= ((internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module OR internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) OR internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module) OR internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  --cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  cpu_0_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  cpu_0_jtag_debug_module_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(cpu_0_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_0_jtag_debug_module_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(cpu_0_jtag_debug_module_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_0_jtag_debug_module_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  cpu_0_jtag_debug_module_allgrants <= (((or_reduce(cpu_0_jtag_debug_module_grant_vector)) OR (or_reduce(cpu_0_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_0_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_0_jtag_debug_module_grant_vector));
  --cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  cpu_0_jtag_debug_module_end_xfer <= NOT ((cpu_0_jtag_debug_module_waits_for_read OR cpu_0_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_end_xfer AND (((NOT cpu_0_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  cpu_0_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module AND cpu_0_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module AND NOT cpu_0_jtag_debug_module_non_bursting_master_requests));
  --cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_0_jtag_debug_module_arb_counter_enable) = '1' then 
        cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(cpu_0_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module AND NOT cpu_0_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        cpu_0_jtag_debug_module_slavearbiterlockenable <= or_reduce(cpu_0_jtag_debug_module_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= cpu_0_jtag_debug_module_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  cpu_0_jtag_debug_module_slavearbiterlockenable2 <= or_reduce(cpu_0_jtag_debug_module_arb_share_counter_next_value);
  --cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= cpu_0_jtag_debug_module_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  cpu_0_instruction_master_arbiterlock <= cpu_0_jtag_debug_module_slavearbiterlockenable AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_0_instruction_master_arbiterlock2 <= cpu_0_jtag_debug_module_slavearbiterlockenable2 AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_0_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module))))));
    end if;

  end process;

  --cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  cpu_0_instruction_master_continuerequest <= last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module AND internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  --cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  cpu_0_jtag_debug_module_any_continuerequest <= cpu_0_instruction_master_continuerequest OR cpu_0_data_master_continuerequest;
  internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module AND NOT ((((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))))) OR cpu_0_instruction_master_arbiterlock));
  --local readdatavalid cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module <= (internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_read) AND NOT cpu_0_jtag_debug_module_waits_for_read;
  --cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  cpu_0_jtag_debug_module_writedata <= cpu_0_data_master_writedata;
  internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_instruction_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000010000001000000000000")))) AND (cpu_0_instruction_master_read))) AND cpu_0_instruction_master_read;
  --cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_0_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module))))));
    end if;

  end process;

  --cpu_0_data_master_continuerequest continued request, which is an e_mux
  cpu_0_data_master_continuerequest <= last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module AND internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module AND NOT ((((cpu_0_instruction_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))))) OR cpu_0_data_master_arbiterlock));
  --local readdatavalid cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module <= (internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module AND cpu_0_instruction_master_read) AND NOT cpu_0_jtag_debug_module_waits_for_read;
  --allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_jtag_debug_module_allow_new_arb_cycle <= NOT cpu_0_data_master_arbiterlock AND NOT cpu_0_instruction_master_arbiterlock;
  --cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_jtag_debug_module_master_qreq_vector(0) <= internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  --cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_grant_vector(0);
  --cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_arb_winner(0) AND internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  --cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_jtag_debug_module_master_qreq_vector(1) <= internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  --cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_grant_vector(1);
  --cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_arb_winner(1) AND internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  --cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  cpu_0_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((cpu_0_jtag_debug_module_master_qreq_vector & cpu_0_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT cpu_0_jtag_debug_module_master_qreq_vector & NOT cpu_0_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (cpu_0_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  cpu_0_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((cpu_0_jtag_debug_module_allow_new_arb_cycle AND or_reduce(cpu_0_jtag_debug_module_grant_vector)))) = '1'), cpu_0_jtag_debug_module_grant_vector, cpu_0_jtag_debug_module_saved_chosen_master_vector);
  --saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_0_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        cpu_0_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(cpu_0_jtag_debug_module_grant_vector)) = '1'), cpu_0_jtag_debug_module_grant_vector, cpu_0_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  cpu_0_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((cpu_0_jtag_debug_module_chosen_master_double_vector(1) OR cpu_0_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((cpu_0_jtag_debug_module_chosen_master_double_vector(0) OR cpu_0_jtag_debug_module_chosen_master_double_vector(2)))));
  --cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  cpu_0_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(cpu_0_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(cpu_0_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --cpu_0/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(cpu_0_jtag_debug_module_grant_vector)) = '1' then 
        cpu_0_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(cpu_0_jtag_debug_module_end_xfer) = '1'), cpu_0_jtag_debug_module_chosen_master_rot_left, cpu_0_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  cpu_0_jtag_debug_module_begintransfer <= cpu_0_jtag_debug_module_begins_xfer;
  --cpu_0_jtag_debug_module_reset_n assignment, which is an e_assign
  cpu_0_jtag_debug_module_reset_n <= reset_n;
  --assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_0_jtag_debug_module_resetrequest_from_sa <= cpu_0_jtag_debug_module_resetrequest;
  cpu_0_jtag_debug_module_chipselect <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module OR internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  --cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  cpu_0_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(cpu_0_jtag_debug_module_begins_xfer) = '1'), cpu_0_jtag_debug_module_unreg_firsttransfer, cpu_0_jtag_debug_module_reg_firsttransfer);
  --cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  cpu_0_jtag_debug_module_unreg_firsttransfer <= NOT ((cpu_0_jtag_debug_module_slavearbiterlockenable AND cpu_0_jtag_debug_module_any_continuerequest));
  --cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_0_jtag_debug_module_begins_xfer) = '1' then 
        cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  cpu_0_jtag_debug_module_beginbursttransfer_internal <= cpu_0_jtag_debug_module_begins_xfer;
  --cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  cpu_0_jtag_debug_module_arbitration_holdoff_internal <= cpu_0_jtag_debug_module_begins_xfer AND cpu_0_jtag_debug_module_firsttransfer;
  --cpu_0_jtag_debug_module_write assignment, which is an e_mux
  cpu_0_jtag_debug_module_write <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_write;
  shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --cpu_0_jtag_debug_module_address mux, which is an e_mux
  cpu_0_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master <= cpu_0_instruction_master_address_to_slave;
  --d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_cpu_0_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end if;

  end process;

  --cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  cpu_0_jtag_debug_module_waits_for_read <= cpu_0_jtag_debug_module_in_a_read_cycle AND cpu_0_jtag_debug_module_begins_xfer;
  --cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  cpu_0_jtag_debug_module_in_a_read_cycle <= ((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module AND cpu_0_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= cpu_0_jtag_debug_module_in_a_read_cycle;
  --cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  cpu_0_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  cpu_0_jtag_debug_module_in_a_write_cycle <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= cpu_0_jtag_debug_module_in_a_write_cycle;
  wait_for_cpu_0_jtag_debug_module_counter <= std_logic'('0');
  --cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  cpu_0_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_0_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --debugaccess mux, which is an e_mux
  cpu_0_jtag_debug_module_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_granted_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_requests_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
--synthesis translate_off
    --cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line1 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_0_data_master_arbitrator is 
        port (
              -- inputs:
                 signal HC_12_s1_irq_from_sa : IN STD_LOGIC;
                 signal HC_12_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal US_100_UART_s1_irq_from_sa : IN STD_LOGIC;
                 signal US_100_UART_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal addr2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal addr3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal addr4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal addr_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cfi_flash_0_s1_wait_counter_eq_0 : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_byteenable_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_byteenable_sdram_0_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_granted_HC_12_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_US_100_UART_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_addr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_addr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_addr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_addr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_pio_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_pio_1_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_pio_2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_pio_3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_pio_4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_sysid_0_control_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_timer_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_wr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_wr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_wr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_wr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_HC_12_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_US_100_UART_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_addr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_1_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_sysid_0_control_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_timer_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_HC_12_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_US_100_UART_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_addr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_1_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sysid_0_control_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_timer_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_HC_12_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_US_100_UART_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_addr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_addr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_addr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_addr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_1_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_sysid_0_control_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_timer_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_wr2_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_wr3_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_wr4_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_wr_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_HC_12_s1_end_xfer : IN STD_LOGIC;
                 signal d1_US_100_UART_s1_end_xfer : IN STD_LOGIC;
                 signal d1_addr2_s1_end_xfer : IN STD_LOGIC;
                 signal d1_addr3_s1_end_xfer : IN STD_LOGIC;
                 signal d1_addr4_s1_end_xfer : IN STD_LOGIC;
                 signal d1_addr_s1_end_xfer : IN STD_LOGIC;
                 signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_epcs_flash_controller_0_epcs_control_port_end_xfer : IN STD_LOGIC;
                 signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_opencores_i2c_jy901_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_pio_0_s1_end_xfer : IN STD_LOGIC;
                 signal d1_pio_1_s1_end_xfer : IN STD_LOGIC;
                 signal d1_pio_2_s1_end_xfer : IN STD_LOGIC;
                 signal d1_pio_3_s1_end_xfer : IN STD_LOGIC;
                 signal d1_pio_4_s1_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                 signal d1_sysid_0_control_slave_end_xfer : IN STD_LOGIC;
                 signal d1_timer_0_s1_end_xfer : IN STD_LOGIC;
                 signal d1_tri_state_bridge_0_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_wr2_s1_end_xfer : IN STD_LOGIC;
                 signal d1_wr3_s1_end_xfer : IN STD_LOGIC;
                 signal d1_wr4_s1_end_xfer : IN STD_LOGIC;
                 signal d1_wr_s1_end_xfer : IN STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_irq_from_sa : IN STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_irq_from_sa : IN STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa : IN STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_irq_from_sa : IN STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa : IN STD_LOGIC;
                 signal pio_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;
                 signal sysid_0_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal timer_0_s1_irq_from_sa : IN STD_LOGIC;
                 signal timer_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal wr2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal wr3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal wr4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal wr_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_0_data_master_dbs_write_8 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_0_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_0_data_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_0_data_master_arbitrator;


architecture europa of cpu_0_data_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_0_data_master_address_last_time :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_0_data_master_byteenable_last_time :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_data_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_rdv_counter_inc :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_0_data_master_next_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_0_data_master_read_last_time :  STD_LOGIC;
                signal cpu_0_data_master_run :  STD_LOGIC;
                signal cpu_0_data_master_write_last_time :  STD_LOGIC;
                signal cpu_0_data_master_writedata_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_latent_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_latent_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_latent_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_rdv_count_enable :  STD_LOGIC;
                signal dbs_rdv_counter_overflow :  STD_LOGIC;
                signal internal_cpu_0_data_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal internal_cpu_0_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_data_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_data_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_0_data_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_cpu_0_data_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;
                signal r_3 :  STD_LOGIC;
                signal r_4 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_HC_12_s1 OR NOT cpu_0_data_master_requests_HC_12_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_HC_12_s1 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_HC_12_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_HC_12_s1 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_HC_12_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_US_100_UART_s1 OR NOT cpu_0_data_master_requests_US_100_UART_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_US_100_UART_s1 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_US_100_UART_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_US_100_UART_s1 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_US_100_UART_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_addr_s1 OR NOT cpu_0_data_master_requests_addr_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_addr_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_addr2_s1 OR NOT cpu_0_data_master_requests_addr2_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr2_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_addr2_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr2_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_addr3_s1 OR NOT cpu_0_data_master_requests_addr3_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr3_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_addr3_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr3_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_0_data_master_run <= (((r_0 AND r_1) AND r_2) AND r_3) AND r_4;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_addr4_s1 OR NOT cpu_0_data_master_requests_addr4_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr4_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_addr4_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_addr4_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_requests_cpu_0_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_granted_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_0_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port OR NOT cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port OR NOT cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_0_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_0_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave OR NOT cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 OR NOT cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0)))))));
  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 OR NOT cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_pio_0_s1 OR NOT cpu_0_data_master_requests_pio_0_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_0_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_pio_0_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_0_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_pio_1_s1 OR NOT cpu_0_data_master_requests_pio_1_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_1_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_pio_1_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_1_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_pio_2_s1 OR NOT cpu_0_data_master_requests_pio_2_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_2_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_pio_2_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_2_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_pio_3_s1 OR NOT cpu_0_data_master_requests_pio_3_s1)))))));
  --r_3 master_run cascaded wait assignment, which is an e_assign
  r_3 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_3_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_pio_3_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_3_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_pio_4_s1 OR NOT cpu_0_data_master_requests_pio_4_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_4_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_pio_4_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_pio_4_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((cpu_0_data_master_qualified_request_sdram_0_s1 OR (((cpu_0_data_master_write AND NOT(or_reduce(cpu_0_data_master_byteenable_sdram_0_s1))) AND internal_cpu_0_data_master_dbs_address(1)))) OR NOT cpu_0_data_master_requests_sdram_0_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_granted_sdram_0_s1 OR NOT cpu_0_data_master_qualified_request_sdram_0_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_sdram_0_s1 OR NOT cpu_0_data_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_sdram_0_s1 OR NOT cpu_0_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_sysid_0_control_slave OR NOT cpu_0_data_master_requests_sysid_0_control_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_sysid_0_control_slave OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_sysid_0_control_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_sysid_0_control_slave OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_timer_0_s1 OR NOT cpu_0_data_master_requests_timer_0_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_timer_0_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_timer_0_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_timer_0_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")));
  --r_4 master_run cascaded wait assignment, which is an e_assign
  r_4 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((cpu_0_data_master_qualified_request_cfi_flash_0_s1 OR ((((cpu_0_data_master_write AND NOT(cpu_0_data_master_byteenable_cfi_flash_0_s1)) AND internal_cpu_0_data_master_dbs_address(1)) AND internal_cpu_0_data_master_dbs_address(0)))) OR NOT cpu_0_data_master_requests_cfi_flash_0_s1)) AND ((cpu_0_data_master_granted_cfi_flash_0_s1 OR NOT cpu_0_data_master_qualified_request_cfi_flash_0_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_cfi_flash_0_s1 OR NOT cpu_0_data_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cfi_flash_0_s1_wait_counter_eq_0 AND NOT d1_tri_state_bridge_0_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_0_data_master_dbs_address(1) AND internal_cpu_0_data_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_cfi_flash_0_s1 OR NOT cpu_0_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cfi_flash_0_s1_wait_counter_eq_0 AND NOT d1_tri_state_bridge_0_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_0_data_master_dbs_address(1) AND internal_cpu_0_data_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_wr_s1 OR NOT cpu_0_data_master_requests_wr_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_wr_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_wr2_s1 OR NOT cpu_0_data_master_requests_wr2_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr2_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_wr2_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr2_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_wr3_s1 OR NOT cpu_0_data_master_requests_wr3_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr3_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_wr3_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr3_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_wr4_s1 OR NOT cpu_0_data_master_requests_wr4_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr4_s1 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_wr4_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_wr4_s1 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_0_data_master_address_to_slave <= cpu_0_data_master_address(26 DOWNTO 0);
  --cpu_0_data_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_data_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_0_data_master_read_but_no_slave_selected <= (cpu_0_data_master_read AND cpu_0_data_master_run) AND NOT cpu_0_data_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_0_data_master_is_granted_some_slave <= ((((((((((((((((((((((cpu_0_data_master_granted_HC_12_s1 OR cpu_0_data_master_granted_US_100_UART_s1) OR cpu_0_data_master_granted_addr_s1) OR cpu_0_data_master_granted_addr2_s1) OR cpu_0_data_master_granted_addr3_s1) OR cpu_0_data_master_granted_addr4_s1) OR cpu_0_data_master_granted_cpu_0_jtag_debug_module) OR cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port) OR cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave) OR cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0) OR cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0) OR cpu_0_data_master_granted_pio_0_s1) OR cpu_0_data_master_granted_pio_1_s1) OR cpu_0_data_master_granted_pio_2_s1) OR cpu_0_data_master_granted_pio_3_s1) OR cpu_0_data_master_granted_pio_4_s1) OR cpu_0_data_master_granted_sdram_0_s1) OR cpu_0_data_master_granted_sysid_0_control_slave) OR cpu_0_data_master_granted_timer_0_s1) OR cpu_0_data_master_granted_cfi_flash_0_s1) OR cpu_0_data_master_granted_wr_s1) OR cpu_0_data_master_granted_wr2_s1) OR cpu_0_data_master_granted_wr3_s1) OR cpu_0_data_master_granted_wr4_s1;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_0_data_master_readdatavalid <= ((cpu_0_data_master_read_data_valid_sdram_0_s1 AND dbs_rdv_counter_overflow)) OR ((cpu_0_data_master_read_data_valid_cfi_flash_0_s1 AND dbs_rdv_counter_overflow));
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_0_data_master_readdatavalid <= ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((cpu_0_data_master_read_but_no_slave_selected OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_HC_12_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_US_100_UART_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_addr_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_addr2_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_addr3_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_addr4_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_pio_0_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_pio_1_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_pio_2_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_pio_3_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_pio_4_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_sysid_0_control_slave) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_timer_0_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_wr_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_wr2_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_wr3_s1) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_wr4_s1;
  --cpu_0/data_master readdata mux, which is an e_mux
  cpu_0_data_master_readdata <= ((((((((((((((((((((((((A_REP(NOT ((cpu_0_data_master_qualified_request_HC_12_s1 AND cpu_0_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (HC_12_s1_readdata_from_sa)))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_US_100_UART_s1 AND cpu_0_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (US_100_UART_s1_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_addr_s1 AND cpu_0_data_master_read)) , 32) OR addr_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_addr2_s1 AND cpu_0_data_master_read)) , 32) OR addr2_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_addr3_s1 AND cpu_0_data_master_read)) , 32) OR addr3_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_addr4_s1 AND cpu_0_data_master_read)) , 32) OR addr4_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module AND cpu_0_data_master_read)) , 32) OR cpu_0_jtag_debug_module_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port AND cpu_0_data_master_read)) , 32) OR epcs_flash_controller_0_epcs_control_port_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read)) , 32) OR jtag_uart_0_avalon_jtag_slave_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 AND cpu_0_data_master_read)) , 32) OR (std_logic_vector'("000000000000000000000000") & (opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 AND cpu_0_data_master_read)) , 32) OR (std_logic_vector'("000000000000000000000000") & (opencores_i2c_jy901_avalon_slave_0_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_pio_0_s1 AND cpu_0_data_master_read)) , 32) OR pio_0_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_pio_1_s1 AND cpu_0_data_master_read)) , 32) OR pio_1_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_pio_2_s1 AND cpu_0_data_master_read)) , 32) OR pio_2_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_pio_3_s1 AND cpu_0_data_master_read)) , 32) OR pio_3_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_pio_4_s1 AND cpu_0_data_master_read)) , 32) OR pio_4_s1_readdata_from_sa))) AND ((A_REP(NOT cpu_0_data_master_read_data_valid_sdram_0_s1, 32) OR Std_Logic_Vector'(sdram_0_s1_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_sysid_0_control_slave AND cpu_0_data_master_read)) , 32) OR sysid_0_control_slave_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_timer_0_s1 AND cpu_0_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (timer_0_s1_readdata_from_sa))))) AND ((A_REP(NOT cpu_0_data_master_read_data_valid_cfi_flash_0_s1, 32) OR Std_Logic_Vector'(incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(7 DOWNTO 0) & dbs_latent_8_reg_segment_2 & dbs_latent_8_reg_segment_1 & dbs_latent_8_reg_segment_0)))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_wr_s1 AND cpu_0_data_master_read)) , 32) OR wr_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_wr2_s1 AND cpu_0_data_master_read)) , 32) OR wr2_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_wr3_s1 AND cpu_0_data_master_read)) , 32) OR wr3_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_wr4_s1 AND cpu_0_data_master_read)) , 32) OR wr4_s1_readdata_from_sa));
  --actual waitrequest port, which is an e_assign
  internal_cpu_0_data_master_waitrequest <= NOT cpu_0_data_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_data_master_latency_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      internal_cpu_0_data_master_latency_counter <= p1_cpu_0_data_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_0_data_master_latency_counter <= A_EXT (A_WE_StdLogicVector((std_logic'(((cpu_0_data_master_run AND cpu_0_data_master_read))) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (latency_load_value)), A_WE_StdLogicVector((((internal_cpu_0_data_master_latency_counter)) /= std_logic_vector'("00")), ((std_logic_vector'("0000000000000000000000000000000") & (internal_cpu_0_data_master_latency_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --read latency load values, which is an e_mux
  latency_load_value <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (A_REP(cpu_0_data_master_requests_cfi_flash_0_s1, 2))) AND std_logic_vector'("00000000000000000000000000000010")), 2);
  --irq assign, which is an e_assign
  cpu_0_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(opencores_i2c_fbm320_avalon_slave_0_irq_from_sa) & A_ToStdLogicVector(HC_12_s1_irq_from_sa) & A_ToStdLogicVector(US_100_UART_s1_irq_from_sa) & A_ToStdLogicVector(opencores_i2c_jy901_avalon_slave_0_irq_from_sa) & A_ToStdLogicVector(epcs_flash_controller_0_epcs_control_port_irq_from_sa) & A_ToStdLogicVector(jtag_uart_0_avalon_jtag_slave_irq_from_sa) & A_ToStdLogicVector(timer_0_s1_irq_from_sa));
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((((((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_requests_sdram_0_s1)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(cpu_0_data_master_byteenable_sdram_0_s1))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_requests_cfi_flash_0_s1)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(cpu_0_data_master_byteenable_cfi_flash_0_s1))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_cfi_flash_0_s1 AND cpu_0_data_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cfi_flash_0_s1_wait_counter_eq_0 AND NOT d1_tri_state_bridge_0_avalon_slave_end_xfer)))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_cfi_flash_0_s1 AND cpu_0_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cfi_flash_0_s1_wait_counter_eq_0 AND NOT d1_tri_state_bridge_0_avalon_slave_end_xfer)))))))));
  --input to latent dbs-16 stored 0, which is an e_mux
  p1_dbs_latent_16_reg_segment_0 <= sdram_0_s1_readdata_from_sa;
  --dbs register for latent dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_dbs_rdv_counter(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
      end if;
    end if;

  end process;

  --mux write dbs 1, which is an e_mux
  cpu_0_data_master_dbs_write_16 <= A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_dbs_address(1))) = '1'), cpu_0_data_master_writedata(31 DOWNTO 16), cpu_0_data_master_writedata(15 DOWNTO 0));
  --dbs count increment, which is an e_mux
  cpu_0_data_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_0_data_master_requests_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((cpu_0_data_master_requests_cfi_flash_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000001"), std_logic_vector'("00000000000000000000000000000000"))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_0_data_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_0_data_master_dbs_address)) + (std_logic_vector'("0") & (cpu_0_data_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_data_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_0_data_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --p1 dbs rdv counter, which is an e_assign
  cpu_0_data_master_next_dbs_rdv_counter <= A_EXT (((std_logic_vector'("0") & (cpu_0_data_master_dbs_rdv_counter)) + (std_logic_vector'("0") & (cpu_0_data_master_dbs_rdv_counter_inc))), 2);
  --cpu_0_data_master_rdv_inc_mux, which is an e_mux
  cpu_0_data_master_dbs_rdv_counter_inc <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_0_data_master_read_data_valid_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --master any slave rdv, which is an e_mux
  dbs_rdv_count_enable <= cpu_0_data_master_read_data_valid_sdram_0_s1 OR cpu_0_data_master_read_data_valid_cfi_flash_0_s1;
  --dbs rdv counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_data_master_dbs_rdv_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_rdv_count_enable) = '1' then 
        cpu_0_data_master_dbs_rdv_counter <= cpu_0_data_master_next_dbs_rdv_counter;
      end if;
    end if;

  end process;

  --dbs rdv counter overflow, which is an e_assign
  dbs_rdv_counter_overflow <= cpu_0_data_master_dbs_rdv_counter(1) AND NOT cpu_0_data_master_next_dbs_rdv_counter(1);
  --input to latent dbs-8 stored 0, which is an e_mux
  p1_dbs_latent_8_reg_segment_0 <= incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0;
  --dbs register for latent dbs-8 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_0_data_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_8_reg_segment_0 <= p1_dbs_latent_8_reg_segment_0;
      end if;
    end if;

  end process;

  --input to latent dbs-8 stored 1, which is an e_mux
  p1_dbs_latent_8_reg_segment_1 <= incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0;
  --dbs register for latent dbs-8 segment 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_1 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_0_data_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000001")))))) = '1' then 
        dbs_latent_8_reg_segment_1 <= p1_dbs_latent_8_reg_segment_1;
      end if;
    end if;

  end process;

  --input to latent dbs-8 stored 2, which is an e_mux
  p1_dbs_latent_8_reg_segment_2 <= incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0;
  --dbs register for latent dbs-8 segment 2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_2 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_0_data_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000010")))))) = '1' then 
        dbs_latent_8_reg_segment_2 <= p1_dbs_latent_8_reg_segment_2;
      end if;
    end if;

  end process;

  --mux write dbs 2, which is an e_mux
  cpu_0_data_master_dbs_write_8 <= A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_0_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_0_data_master_writedata(7 DOWNTO 0), A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_0_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000001"))), cpu_0_data_master_writedata(15 DOWNTO 8), A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_0_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000010"))), cpu_0_data_master_writedata(23 DOWNTO 16), cpu_0_data_master_writedata(31 DOWNTO 24))));
  --vhdl renameroo for output signals
  cpu_0_data_master_address_to_slave <= internal_cpu_0_data_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_dbs_address <= internal_cpu_0_data_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_0_data_master_latency_counter <= internal_cpu_0_data_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_0_data_master_waitrequest <= internal_cpu_0_data_master_waitrequest;
--synthesis translate_off
    --cpu_0_data_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_address_last_time <= std_logic_vector'("000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_0_data_master_address_last_time <= cpu_0_data_master_address;
      end if;

    end process;

    --cpu_0/data_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_0_data_master_waitrequest AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
      end if;

    end process;

    --cpu_0_data_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_0_data_master_address /= cpu_0_data_master_address_last_time))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("cpu_0_data_master_address did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_byteenable_last_time <= std_logic_vector'("0000");
      elsif clk'event and clk = '1' then
        cpu_0_data_master_byteenable_last_time <= cpu_0_data_master_byteenable;
      end if;

    end process;

    --cpu_0_data_master_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_0_data_master_byteenable /= cpu_0_data_master_byteenable_last_time))))) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("cpu_0_data_master_byteenable did not heed wait!!!"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_0_data_master_read_last_time <= cpu_0_data_master_read;
      end if;

    end process;

    --cpu_0_data_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line4 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_0_data_master_read) /= std_logic'(cpu_0_data_master_read_last_time)))))) = '1' then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("cpu_0_data_master_read did not heed wait!!!"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_0_data_master_write_last_time <= cpu_0_data_master_write;
      end if;

    end process;

    --cpu_0_data_master_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line5 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_0_data_master_write) /= std_logic'(cpu_0_data_master_write_last_time)))))) = '1' then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("cpu_0_data_master_write did not heed wait!!!"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_writedata_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_0_data_master_writedata_last_time <= cpu_0_data_master_writedata;
      end if;

    end process;

    --cpu_0_data_master_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line6 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((cpu_0_data_master_writedata /= cpu_0_data_master_writedata_last_time)))) AND cpu_0_data_master_write)) = '1' then 
          write(write_line6, now);
          write(write_line6, string'(": "));
          write(write_line6, string'("cpu_0_data_master_writedata did not heed wait!!!"));
          write(output, write_line6.all);
          deallocate (write_line6);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_0_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal cfi_flash_0_s1_wait_counter_eq_0 : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_instruction_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_instruction_master_granted_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_instruction_master_granted_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_instruction_master_requests_cfi_flash_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                 signal cpu_0_instruction_master_requests_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_epcs_flash_controller_0_epcs_control_port_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                 signal d1_tri_state_bridge_0_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal incoming_data_to_and_from_the_cfi_flash_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_instruction_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_0_instruction_master_arbitrator;


architecture europa of cpu_0_instruction_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_0_instruction_master_address_last_time :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_rdv_counter_inc :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_0_instruction_master_next_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_0_instruction_master_read_last_time :  STD_LOGIC;
                signal cpu_0_instruction_master_run :  STD_LOGIC;
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_latent_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_latent_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_latent_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_rdv_count_enable :  STD_LOGIC;
                signal dbs_rdv_counter_overflow :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal internal_cpu_0_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_instruction_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_0_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_cpu_0_instruction_master_readdatavalid :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_3 :  STD_LOGIC;
                signal r_4 :  STD_LOGIC;

begin

  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_instruction_master_requests_cpu_0_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_granted_cpu_0_jtag_debug_module OR NOT cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_0_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_read)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port OR NOT cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port OR NOT cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port OR NOT (cpu_0_instruction_master_read))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_0_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_instruction_master_read))))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_0_instruction_master_run <= (r_1 AND r_3) AND r_4;
  --r_3 master_run cascaded wait assignment, which is an e_assign
  r_3 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_qualified_request_sdram_0_s1 OR NOT cpu_0_instruction_master_requests_sdram_0_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_granted_sdram_0_s1 OR NOT cpu_0_instruction_master_qualified_request_sdram_0_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_instruction_master_qualified_request_sdram_0_s1 OR NOT cpu_0_instruction_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_instruction_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_read)))))))));
  --r_4 master_run cascaded wait assignment, which is an e_assign
  r_4 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 OR NOT cpu_0_instruction_master_requests_cfi_flash_0_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_granted_cfi_flash_0_s1 OR NOT cpu_0_instruction_master_qualified_request_cfi_flash_0_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 OR NOT cpu_0_instruction_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cfi_flash_0_s1_wait_counter_eq_0 AND NOT d1_tri_state_bridge_0_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_0_instruction_master_dbs_address(1) AND internal_cpu_0_instruction_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_read)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_0_instruction_master_address_to_slave <= cpu_0_instruction_master_address(26 DOWNTO 0);
  --cpu_0_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_instruction_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_0_instruction_master_read_but_no_slave_selected <= (cpu_0_instruction_master_read AND cpu_0_instruction_master_run) AND NOT cpu_0_instruction_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_0_instruction_master_is_granted_some_slave <= ((cpu_0_instruction_master_granted_cpu_0_jtag_debug_module OR cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port) OR cpu_0_instruction_master_granted_sdram_0_s1) OR cpu_0_instruction_master_granted_cfi_flash_0_s1;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_0_instruction_master_readdatavalid <= ((cpu_0_instruction_master_read_data_valid_sdram_0_s1 AND dbs_rdv_counter_overflow)) OR ((cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 AND dbs_rdv_counter_overflow));
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_0_instruction_master_readdatavalid <= ((((((((cpu_0_instruction_master_read_but_no_slave_selected OR pre_flush_cpu_0_instruction_master_readdatavalid) OR cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module) OR cpu_0_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_0_instruction_master_readdatavalid) OR cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port) OR cpu_0_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_0_instruction_master_readdatavalid) OR cpu_0_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_0_instruction_master_readdatavalid;
  --cpu_0/instruction_master readdata mux, which is an e_mux
  cpu_0_instruction_master_readdata <= ((((A_REP(NOT ((cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module AND cpu_0_instruction_master_read)) , 32) OR cpu_0_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT ((cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port AND cpu_0_instruction_master_read)) , 32) OR epcs_flash_controller_0_epcs_control_port_readdata_from_sa))) AND ((A_REP(NOT cpu_0_instruction_master_read_data_valid_sdram_0_s1, 32) OR Std_Logic_Vector'(sdram_0_s1_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)))) AND ((A_REP(NOT cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1, 32) OR Std_Logic_Vector'(incoming_data_to_and_from_the_cfi_flash_0(7 DOWNTO 0) & dbs_latent_8_reg_segment_2 & dbs_latent_8_reg_segment_1 & dbs_latent_8_reg_segment_0)));
  --actual waitrequest port, which is an e_assign
  internal_cpu_0_instruction_master_waitrequest <= NOT cpu_0_instruction_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_instruction_master_latency_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      internal_cpu_0_instruction_master_latency_counter <= p1_cpu_0_instruction_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_0_instruction_master_latency_counter <= A_EXT (A_WE_StdLogicVector((std_logic'(((cpu_0_instruction_master_run AND cpu_0_instruction_master_read))) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (latency_load_value)), A_WE_StdLogicVector((((internal_cpu_0_instruction_master_latency_counter)) /= std_logic_vector'("00")), ((std_logic_vector'("0000000000000000000000000000000") & (internal_cpu_0_instruction_master_latency_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --read latency load values, which is an e_mux
  latency_load_value <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (A_REP(cpu_0_instruction_master_requests_cfi_flash_0_s1, 2))) AND std_logic_vector'("00000000000000000000000000000010")), 2);
  --input to latent dbs-16 stored 0, which is an e_mux
  p1_dbs_latent_16_reg_segment_0 <= sdram_0_s1_readdata_from_sa;
  --dbs register for latent dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_instruction_master_dbs_rdv_counter(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
      end if;
    end if;

  end process;

  --dbs count increment, which is an e_mux
  cpu_0_instruction_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_0_instruction_master_requests_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((cpu_0_instruction_master_requests_cfi_flash_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000001"), std_logic_vector'("00000000000000000000000000000000"))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_0_instruction_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_0_instruction_master_dbs_address)) + (std_logic_vector'("0") & (cpu_0_instruction_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_instruction_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_0_instruction_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --p1 dbs rdv counter, which is an e_assign
  cpu_0_instruction_master_next_dbs_rdv_counter <= A_EXT (((std_logic_vector'("0") & (cpu_0_instruction_master_dbs_rdv_counter)) + (std_logic_vector'("0") & (cpu_0_instruction_master_dbs_rdv_counter_inc))), 2);
  --cpu_0_instruction_master_rdv_inc_mux, which is an e_mux
  cpu_0_instruction_master_dbs_rdv_counter_inc <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_0_instruction_master_read_data_valid_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --master any slave rdv, which is an e_mux
  dbs_rdv_count_enable <= cpu_0_instruction_master_read_data_valid_sdram_0_s1 OR cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1;
  --dbs rdv counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_instruction_master_dbs_rdv_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_rdv_count_enable) = '1' then 
        cpu_0_instruction_master_dbs_rdv_counter <= cpu_0_instruction_master_next_dbs_rdv_counter;
      end if;
    end if;

  end process;

  --dbs rdv counter overflow, which is an e_assign
  dbs_rdv_counter_overflow <= cpu_0_instruction_master_dbs_rdv_counter(1) AND NOT cpu_0_instruction_master_next_dbs_rdv_counter(1);
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_instruction_master_granted_sdram_0_s1 AND cpu_0_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_instruction_master_granted_cfi_flash_0_s1 AND cpu_0_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cfi_flash_0_s1_wait_counter_eq_0 AND NOT d1_tri_state_bridge_0_avalon_slave_end_xfer)))))))));
  --input to latent dbs-8 stored 0, which is an e_mux
  p1_dbs_latent_8_reg_segment_0 <= incoming_data_to_and_from_the_cfi_flash_0;
  --dbs register for latent dbs-8 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_0_instruction_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_8_reg_segment_0 <= p1_dbs_latent_8_reg_segment_0;
      end if;
    end if;

  end process;

  --input to latent dbs-8 stored 1, which is an e_mux
  p1_dbs_latent_8_reg_segment_1 <= incoming_data_to_and_from_the_cfi_flash_0;
  --dbs register for latent dbs-8 segment 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_1 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_0_instruction_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000001")))))) = '1' then 
        dbs_latent_8_reg_segment_1 <= p1_dbs_latent_8_reg_segment_1;
      end if;
    end if;

  end process;

  --input to latent dbs-8 stored 2, which is an e_mux
  p1_dbs_latent_8_reg_segment_2 <= incoming_data_to_and_from_the_cfi_flash_0;
  --dbs register for latent dbs-8 segment 2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_2 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_0_instruction_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000010")))))) = '1' then 
        dbs_latent_8_reg_segment_2 <= p1_dbs_latent_8_reg_segment_2;
      end if;
    end if;

  end process;

  --vhdl renameroo for output signals
  cpu_0_instruction_master_address_to_slave <= internal_cpu_0_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_dbs_address <= internal_cpu_0_instruction_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_latency_counter <= internal_cpu_0_instruction_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_waitrequest <= internal_cpu_0_instruction_master_waitrequest;
--synthesis translate_off
    --cpu_0_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_instruction_master_address_last_time <= std_logic_vector'("000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
      end if;

    end process;

    --cpu_0/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_0_instruction_master_waitrequest AND (cpu_0_instruction_master_read);
      end if;

    end process;

    --cpu_0_instruction_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line7 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_0_instruction_master_address /= cpu_0_instruction_master_address_last_time))))) = '1' then 
          write(write_line7, now);
          write(write_line7, string'(": "));
          write(write_line7, string'("cpu_0_instruction_master_address did not heed wait!!!"));
          write(output, write_line7.all);
          deallocate (write_line7);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
      end if;

    end process;

    --cpu_0_instruction_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line8 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_0_instruction_master_read) /= std_logic'(cpu_0_instruction_master_read_last_time)))))) = '1' then 
          write(write_line8, now);
          write(write_line8, string'(": "));
          write(write_line8, string'("cpu_0_instruction_master_read did not heed wait!!!"));
          write(output, write_line8.all);
          deallocate (write_line8);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity epcs_flash_controller_0_epcs_control_port_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_dataavailable : IN STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_endofpacket : IN STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_irq : IN STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal epcs_flash_controller_0_epcs_control_port_readyfordata : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                 signal d1_epcs_flash_controller_0_epcs_control_port_end_xfer : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal epcs_flash_controller_0_epcs_control_port_chipselect : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_irq_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_read_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_reset_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_write_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_0_epcs_control_port_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity epcs_flash_controller_0_epcs_control_port_arbitrator;


architecture europa of epcs_flash_controller_0_epcs_control_port_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_allgrants :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_any_continuerequest :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_arb_counter_enable :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_beginbursttransfer_internal :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_begins_xfer :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_end_xfer :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_in_a_read_cycle :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_in_a_write_cycle :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_reg_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_waits_for_read :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_instruction_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_epcs_flash_controller_0_epcs_control_port_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT epcs_flash_controller_0_epcs_control_port_end_xfer;
    end if;

  end process;

  epcs_flash_controller_0_epcs_control_port_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port OR internal_cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port));
  --assign epcs_flash_controller_0_epcs_control_port_readdata_from_sa = epcs_flash_controller_0_epcs_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_readdata_from_sa <= epcs_flash_controller_0_epcs_control_port_readdata;
  internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000010000001100000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa = epcs_flash_controller_0_epcs_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa <= epcs_flash_controller_0_epcs_control_port_dataavailable;
  --assign epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa = epcs_flash_controller_0_epcs_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa <= epcs_flash_controller_0_epcs_control_port_readyfordata;
  --epcs_flash_controller_0_epcs_control_port_arb_share_counter set values, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_arb_share_set_values <= std_logic_vector'("001");
  --epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests mux, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests <= ((internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port OR internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port) OR internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port) OR internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
  --epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant <= std_logic'('0');
  --epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value assignment, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(epcs_flash_controller_0_epcs_control_port_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (epcs_flash_controller_0_epcs_control_port_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(epcs_flash_controller_0_epcs_control_port_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (epcs_flash_controller_0_epcs_control_port_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --epcs_flash_controller_0_epcs_control_port_allgrants all slave grants, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_allgrants <= (((or_reduce(epcs_flash_controller_0_epcs_control_port_grant_vector)) OR (or_reduce(epcs_flash_controller_0_epcs_control_port_grant_vector))) OR (or_reduce(epcs_flash_controller_0_epcs_control_port_grant_vector))) OR (or_reduce(epcs_flash_controller_0_epcs_control_port_grant_vector));
  --epcs_flash_controller_0_epcs_control_port_end_xfer assignment, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_end_xfer <= NOT ((epcs_flash_controller_0_epcs_control_port_waits_for_read OR epcs_flash_controller_0_epcs_control_port_waits_for_write));
  --end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port <= epcs_flash_controller_0_epcs_control_port_end_xfer AND (((NOT epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --epcs_flash_controller_0_epcs_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_arb_counter_enable <= ((end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port AND epcs_flash_controller_0_epcs_control_port_allgrants)) OR ((end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port AND NOT epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests));
  --epcs_flash_controller_0_epcs_control_port_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_0_epcs_control_port_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_0_epcs_control_port_arb_counter_enable) = '1' then 
        epcs_flash_controller_0_epcs_control_port_arb_share_counter <= epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(epcs_flash_controller_0_epcs_control_port_master_qreq_vector) AND end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port)) OR ((end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port AND NOT epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests)))) = '1' then 
        epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable <= or_reduce(epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master epcs_flash_controller_0/epcs_control_port arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 <= or_reduce(epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value);
  --cpu_0/data_master epcs_flash_controller_0/epcs_control_port arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --cpu_0/instruction_master epcs_flash_controller_0/epcs_control_port arbiterlock, which is an e_assign
  cpu_0_instruction_master_arbiterlock <= epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master epcs_flash_controller_0/epcs_control_port arbiterlock2, which is an e_assign
  cpu_0_instruction_master_arbiterlock2 <= epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master granted epcs_flash_controller_0/epcs_control_port last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal OR NOT internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port))))));
    end if;

  end process;

  --cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  cpu_0_instruction_master_continuerequest <= last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port AND internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
  --epcs_flash_controller_0_epcs_control_port_any_continuerequest at least one master continues requesting, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_any_continuerequest <= cpu_0_instruction_master_continuerequest OR cpu_0_data_master_continuerequest;
  internal_cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port AND NOT ((((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))))) OR cpu_0_instruction_master_arbiterlock));
  --local readdatavalid cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port, which is an e_mux
  cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port <= (internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_data_master_read) AND NOT epcs_flash_controller_0_epcs_control_port_waits_for_read;
  --epcs_flash_controller_0_epcs_control_port_writedata mux, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_writedata <= cpu_0_data_master_writedata;
  --assign epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa = epcs_flash_controller_0_epcs_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa <= epcs_flash_controller_0_epcs_control_port_endofpacket;
  internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_instruction_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000010000001100000000000")))) AND (cpu_0_instruction_master_read))) AND cpu_0_instruction_master_read;
  --cpu_0/data_master granted epcs_flash_controller_0/epcs_control_port last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal OR NOT internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port))))));
    end if;

  end process;

  --cpu_0_data_master_continuerequest continued request, which is an e_mux
  cpu_0_data_master_continuerequest <= last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port AND internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;
  internal_cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port AND NOT ((((cpu_0_instruction_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))))) OR cpu_0_data_master_arbiterlock));
  --local readdatavalid cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port, which is an e_mux
  cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port <= (internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_instruction_master_read) AND NOT epcs_flash_controller_0_epcs_control_port_waits_for_read;
  --allow new arb cycle for epcs_flash_controller_0/epcs_control_port, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle <= NOT cpu_0_data_master_arbiterlock AND NOT cpu_0_instruction_master_arbiterlock;
  --cpu_0/instruction_master assignment into master qualified-requests vector for epcs_flash_controller_0/epcs_control_port, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_master_qreq_vector(0) <= internal_cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  --cpu_0/instruction_master grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port <= epcs_flash_controller_0_epcs_control_port_grant_vector(0);
  --cpu_0/instruction_master saved-grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port <= epcs_flash_controller_0_epcs_control_port_arb_winner(0) AND internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
  --cpu_0/data_master assignment into master qualified-requests vector for epcs_flash_controller_0/epcs_control_port, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_master_qreq_vector(1) <= internal_cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  --cpu_0/data_master grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port <= epcs_flash_controller_0_epcs_control_port_grant_vector(1);
  --cpu_0/data_master saved-grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port <= epcs_flash_controller_0_epcs_control_port_arb_winner(1) AND internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;
  --epcs_flash_controller_0/epcs_control_port chosen-master double-vector, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((epcs_flash_controller_0_epcs_control_port_master_qreq_vector & epcs_flash_controller_0_epcs_control_port_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT epcs_flash_controller_0_epcs_control_port_master_qreq_vector & NOT epcs_flash_controller_0_epcs_control_port_master_qreq_vector))) + (std_logic_vector'("000") & (epcs_flash_controller_0_epcs_control_port_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  epcs_flash_controller_0_epcs_control_port_arb_winner <= A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle AND or_reduce(epcs_flash_controller_0_epcs_control_port_grant_vector)))) = '1'), epcs_flash_controller_0_epcs_control_port_grant_vector, epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector);
  --saved epcs_flash_controller_0_epcs_control_port_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle) = '1' then 
        epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(epcs_flash_controller_0_epcs_control_port_grant_vector)) = '1'), epcs_flash_controller_0_epcs_control_port_grant_vector, epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  epcs_flash_controller_0_epcs_control_port_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector(1) OR epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector(0) OR epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector(2)))));
  --epcs_flash_controller_0/epcs_control_port chosen master rotated left, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(epcs_flash_controller_0_epcs_control_port_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(epcs_flash_controller_0_epcs_control_port_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --epcs_flash_controller_0/epcs_control_port's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_0_epcs_control_port_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(epcs_flash_controller_0_epcs_control_port_grant_vector)) = '1' then 
        epcs_flash_controller_0_epcs_control_port_arb_addend <= A_WE_StdLogicVector((std_logic'(epcs_flash_controller_0_epcs_control_port_end_xfer) = '1'), epcs_flash_controller_0_epcs_control_port_chosen_master_rot_left, epcs_flash_controller_0_epcs_control_port_grant_vector);
      end if;
    end if;

  end process;

  --epcs_flash_controller_0_epcs_control_port_reset_n assignment, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_reset_n <= reset_n;
  epcs_flash_controller_0_epcs_control_port_chipselect <= internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port OR internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port;
  --epcs_flash_controller_0_epcs_control_port_firsttransfer first transaction, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_firsttransfer <= A_WE_StdLogic((std_logic'(epcs_flash_controller_0_epcs_control_port_begins_xfer) = '1'), epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer, epcs_flash_controller_0_epcs_control_port_reg_firsttransfer);
  --epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer first transaction, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer <= NOT ((epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable AND epcs_flash_controller_0_epcs_control_port_any_continuerequest));
  --epcs_flash_controller_0_epcs_control_port_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_0_epcs_control_port_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_0_epcs_control_port_begins_xfer) = '1' then 
        epcs_flash_controller_0_epcs_control_port_reg_firsttransfer <= epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --epcs_flash_controller_0_epcs_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_beginbursttransfer_internal <= epcs_flash_controller_0_epcs_control_port_begins_xfer;
  --epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal <= epcs_flash_controller_0_epcs_control_port_begins_xfer AND epcs_flash_controller_0_epcs_control_port_firsttransfer;
  --~epcs_flash_controller_0_epcs_control_port_read_n assignment, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_read_n <= NOT ((((internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_instruction_master_read))));
  --~epcs_flash_controller_0_epcs_control_port_write_n assignment, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_write_n <= NOT ((internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_data_master_write));
  shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --epcs_flash_controller_0_epcs_control_port_address mux, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port)) = '1'), (A_SRL(shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_instruction_master <= cpu_0_instruction_master_address_to_slave;
  --d1_epcs_flash_controller_0_epcs_control_port_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_epcs_flash_controller_0_epcs_control_port_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_epcs_flash_controller_0_epcs_control_port_end_xfer <= epcs_flash_controller_0_epcs_control_port_end_xfer;
    end if;

  end process;

  --epcs_flash_controller_0_epcs_control_port_waits_for_read in a cycle, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_waits_for_read <= epcs_flash_controller_0_epcs_control_port_in_a_read_cycle AND epcs_flash_controller_0_epcs_control_port_begins_xfer;
  --epcs_flash_controller_0_epcs_control_port_in_a_read_cycle assignment, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_in_a_read_cycle <= ((internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= epcs_flash_controller_0_epcs_control_port_in_a_read_cycle;
  --epcs_flash_controller_0_epcs_control_port_waits_for_write in a cycle, which is an e_mux
  epcs_flash_controller_0_epcs_control_port_waits_for_write <= epcs_flash_controller_0_epcs_control_port_in_a_write_cycle AND epcs_flash_controller_0_epcs_control_port_begins_xfer;
  --epcs_flash_controller_0_epcs_control_port_in_a_write_cycle assignment, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_in_a_write_cycle <= internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= epcs_flash_controller_0_epcs_control_port_in_a_write_cycle;
  wait_for_epcs_flash_controller_0_epcs_control_port_counter <= std_logic'('0');
  --assign epcs_flash_controller_0_epcs_control_port_irq_from_sa = epcs_flash_controller_0_epcs_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_0_epcs_control_port_irq_from_sa <= epcs_flash_controller_0_epcs_control_port_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port <= internal_cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
--synthesis translate_off
    --epcs_flash_controller_0/epcs_control_port enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line9 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line9, now);
          write(write_line9, string'(": "));
          write(write_line9, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line9.all);
          deallocate (write_line9);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line10 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line10, now);
          write(write_line10, string'(": "));
          write(write_line10, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line10.all);
          deallocate (write_line10);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity jtag_uart_0_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity jtag_uart_0_avalon_jtag_slave_arbitrator;


architecture europa of jtag_uart_0_avalon_jtag_slave_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_jtag_uart_0_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT jtag_uart_0_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  jtag_uart_0_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave);
  --assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_readdata_from_sa <= jtag_uart_0_avalon_jtag_slave_readdata;
  internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100000010000010000011110000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa <= jtag_uart_0_avalon_jtag_slave_dataavailable;
  --assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa <= jtag_uart_0_avalon_jtag_slave_readyfordata;
  --assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa <= jtag_uart_0_avalon_jtag_slave_waitrequest;
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_arb_share_set_values <= std_logic_vector'("001");
  --jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  --jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(jtag_uart_0_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_0_avalon_jtag_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(jtag_uart_0_avalon_jtag_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_0_avalon_jtag_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_allgrants <= jtag_uart_0_avalon_jtag_slave_grant_vector;
  --jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_end_xfer <= NOT ((jtag_uart_0_avalon_jtag_slave_waits_for_read OR jtag_uart_0_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave <= jtag_uart_0_avalon_jtag_slave_end_xfer AND (((NOT jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave AND jtag_uart_0_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave AND NOT jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests));
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_0_avalon_jtag_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_0_avalon_jtag_slave_arb_counter_enable) = '1' then 
        jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((jtag_uart_0_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave AND NOT jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= or_reduce(jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 <= or_reduce(jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value);
  --cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave, which is an e_mux
  cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave <= (internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read) AND NOT jtag_uart_0_avalon_jtag_slave_waits_for_read;
  --jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  --cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  --allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  jtag_uart_0_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  jtag_uart_0_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_reset_n <= reset_n;
  jtag_uart_0_avalon_jtag_slave_chipselect <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  --jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(jtag_uart_0_avalon_jtag_slave_begins_xfer) = '1'), jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer, jtag_uart_0_avalon_jtag_slave_reg_firsttransfer);
  --jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer <= NOT ((jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable AND jtag_uart_0_avalon_jtag_slave_any_continuerequest));
  --jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_0_avalon_jtag_slave_begins_xfer) = '1' then 
        jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal <= jtag_uart_0_avalon_jtag_slave_begins_xfer;
  --~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_read_n <= NOT ((internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read));
  --~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_write_n <= NOT ((internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_write));
  shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  --jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_waits_for_read <= jtag_uart_0_avalon_jtag_slave_in_a_read_cycle AND internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_in_a_read_cycle <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  --jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_waits_for_write <= jtag_uart_0_avalon_jtag_slave_in_a_write_cycle AND internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_in_a_write_cycle <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wait_for_jtag_uart_0_avalon_jtag_slave_counter <= std_logic'('0');
  --assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_irq_from_sa <= jtag_uart_0_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  --vhdl renameroo for output signals
  jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa <= internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
--synthesis translate_off
    --jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity opencores_i2c_fbm320_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal opencores_i2c_fbm320_avalon_slave_0_irq : IN STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal opencores_i2c_fbm320_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_irq_from_sa : OUT STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal opencores_i2c_fbm320_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa : OUT STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_write : OUT STD_LOGIC;
                 signal opencores_i2c_fbm320_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity opencores_i2c_fbm320_avalon_slave_0_arbitrator;


architecture europa of opencores_i2c_fbm320_avalon_slave_0_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal internal_opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_allgrants :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_fbm320_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_fbm320_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_fbm320_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_pretend_byte_enable :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_opencores_i2c_fbm320_avalon_slave_0_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_opencores_i2c_fbm320_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT opencores_i2c_fbm320_avalon_slave_0_end_xfer;
    end if;

  end process;

  opencores_i2c_fbm320_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0);
  --assign opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa = opencores_i2c_fbm320_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa <= opencores_i2c_fbm320_avalon_slave_0_readdata;
  internal_cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("000000000000000000001100000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa = opencores_i2c_fbm320_avalon_slave_0_waitrequest_n so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa <= opencores_i2c_fbm320_avalon_slave_0_waitrequest_n;
  --opencores_i2c_fbm320_avalon_slave_0_arb_share_counter set values, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_arb_share_set_values <= std_logic_vector'("001");
  --opencores_i2c_fbm320_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_non_bursting_master_requests <= internal_cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0;
  --opencores_i2c_fbm320_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --opencores_i2c_fbm320_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(opencores_i2c_fbm320_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (opencores_i2c_fbm320_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(opencores_i2c_fbm320_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (opencores_i2c_fbm320_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --opencores_i2c_fbm320_avalon_slave_0_allgrants all slave grants, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_allgrants <= opencores_i2c_fbm320_avalon_slave_0_grant_vector;
  --opencores_i2c_fbm320_avalon_slave_0_end_xfer assignment, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_end_xfer <= NOT ((opencores_i2c_fbm320_avalon_slave_0_waits_for_read OR opencores_i2c_fbm320_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_opencores_i2c_fbm320_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_opencores_i2c_fbm320_avalon_slave_0 <= opencores_i2c_fbm320_avalon_slave_0_end_xfer AND (((NOT opencores_i2c_fbm320_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --opencores_i2c_fbm320_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_opencores_i2c_fbm320_avalon_slave_0 AND opencores_i2c_fbm320_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_opencores_i2c_fbm320_avalon_slave_0 AND NOT opencores_i2c_fbm320_avalon_slave_0_non_bursting_master_requests));
  --opencores_i2c_fbm320_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      opencores_i2c_fbm320_avalon_slave_0_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(opencores_i2c_fbm320_avalon_slave_0_arb_counter_enable) = '1' then 
        opencores_i2c_fbm320_avalon_slave_0_arb_share_counter <= opencores_i2c_fbm320_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((opencores_i2c_fbm320_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_opencores_i2c_fbm320_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_opencores_i2c_fbm320_avalon_slave_0 AND NOT opencores_i2c_fbm320_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable <= or_reduce(opencores_i2c_fbm320_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master opencores_i2c_fbm320/avalon_slave_0 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(opencores_i2c_fbm320_avalon_slave_0_arb_share_counter_next_value);
  --cpu_0/data_master opencores_i2c_fbm320/avalon_slave_0 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --opencores_i2c_fbm320_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 <= internal_cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0, which is an e_mux
  cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 <= (internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 AND cpu_0_data_master_read) AND NOT opencores_i2c_fbm320_avalon_slave_0_waits_for_read;
  --opencores_i2c_fbm320_avalon_slave_0_writedata mux, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_writedata <= cpu_0_data_master_writedata (7 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0;
  --cpu_0/data_master saved-grant opencores_i2c_fbm320/avalon_slave_0, which is an e_assign
  cpu_0_data_master_saved_grant_opencores_i2c_fbm320_avalon_slave_0 <= internal_cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0;
  --allow new arb cycle for opencores_i2c_fbm320/avalon_slave_0, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  opencores_i2c_fbm320_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  opencores_i2c_fbm320_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~opencores_i2c_fbm320_avalon_slave_0_reset assignment, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_reset <= NOT reset_n;
  opencores_i2c_fbm320_avalon_slave_0_chipselect <= internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0;
  --opencores_i2c_fbm320_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(opencores_i2c_fbm320_avalon_slave_0_begins_xfer) = '1'), opencores_i2c_fbm320_avalon_slave_0_unreg_firsttransfer, opencores_i2c_fbm320_avalon_slave_0_reg_firsttransfer);
  --opencores_i2c_fbm320_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_unreg_firsttransfer <= NOT ((opencores_i2c_fbm320_avalon_slave_0_slavearbiterlockenable AND opencores_i2c_fbm320_avalon_slave_0_any_continuerequest));
  --opencores_i2c_fbm320_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      opencores_i2c_fbm320_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(opencores_i2c_fbm320_avalon_slave_0_begins_xfer) = '1' then 
        opencores_i2c_fbm320_avalon_slave_0_reg_firsttransfer <= opencores_i2c_fbm320_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --opencores_i2c_fbm320_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_beginbursttransfer_internal <= opencores_i2c_fbm320_avalon_slave_0_begins_xfer;
  --opencores_i2c_fbm320_avalon_slave_0_write assignment, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_write <= ((internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 AND cpu_0_data_master_write)) AND opencores_i2c_fbm320_avalon_slave_0_pretend_byte_enable;
  shifted_address_to_opencores_i2c_fbm320_avalon_slave_0_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --opencores_i2c_fbm320_avalon_slave_0_address mux, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_opencores_i2c_fbm320_avalon_slave_0_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer <= opencores_i2c_fbm320_avalon_slave_0_end_xfer;
    end if;

  end process;

  --opencores_i2c_fbm320_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_waits_for_read <= opencores_i2c_fbm320_avalon_slave_0_in_a_read_cycle AND NOT internal_opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa;
  --opencores_i2c_fbm320_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_in_a_read_cycle <= internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= opencores_i2c_fbm320_avalon_slave_0_in_a_read_cycle;
  --opencores_i2c_fbm320_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_waits_for_write <= opencores_i2c_fbm320_avalon_slave_0_in_a_write_cycle AND NOT internal_opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa;
  --opencores_i2c_fbm320_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_in_a_write_cycle <= internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= opencores_i2c_fbm320_avalon_slave_0_in_a_write_cycle;
  wait_for_opencores_i2c_fbm320_avalon_slave_0_counter <= std_logic'('0');
  --opencores_i2c_fbm320_avalon_slave_0_pretend_byte_enable byte enable port mux, which is an e_mux
  opencores_i2c_fbm320_avalon_slave_0_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_0_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  --assign opencores_i2c_fbm320_avalon_slave_0_irq_from_sa = opencores_i2c_fbm320_avalon_slave_0_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  opencores_i2c_fbm320_avalon_slave_0_irq_from_sa <= opencores_i2c_fbm320_avalon_slave_0_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 <= internal_cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 <= internal_cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0;
  --vhdl renameroo for output signals
  opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa <= internal_opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa;
--synthesis translate_off
    --opencores_i2c_fbm320/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity opencores_i2c_jy901_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal opencores_i2c_jy901_avalon_slave_0_irq : IN STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_opencores_i2c_jy901_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal opencores_i2c_jy901_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_irq_from_sa : OUT STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal opencores_i2c_jy901_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa : OUT STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_write : OUT STD_LOGIC;
                 signal opencores_i2c_jy901_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity opencores_i2c_jy901_avalon_slave_0_arbitrator;


architecture europa of opencores_i2c_jy901_avalon_slave_0_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal internal_opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_allgrants :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_jy901_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_jy901_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_jy901_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_pretend_byte_enable :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_opencores_i2c_jy901_avalon_slave_0_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_opencores_i2c_jy901_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT opencores_i2c_jy901_avalon_slave_0_end_xfer;
    end if;

  end process;

  opencores_i2c_jy901_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0);
  --assign opencores_i2c_jy901_avalon_slave_0_readdata_from_sa = opencores_i2c_jy901_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_readdata_from_sa <= opencores_i2c_jy901_avalon_slave_0_readdata;
  internal_cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("000000000000000000000100000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa = opencores_i2c_jy901_avalon_slave_0_waitrequest_n so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa <= opencores_i2c_jy901_avalon_slave_0_waitrequest_n;
  --opencores_i2c_jy901_avalon_slave_0_arb_share_counter set values, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_arb_share_set_values <= std_logic_vector'("001");
  --opencores_i2c_jy901_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_non_bursting_master_requests <= internal_cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0;
  --opencores_i2c_jy901_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --opencores_i2c_jy901_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(opencores_i2c_jy901_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (opencores_i2c_jy901_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(opencores_i2c_jy901_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (opencores_i2c_jy901_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --opencores_i2c_jy901_avalon_slave_0_allgrants all slave grants, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_allgrants <= opencores_i2c_jy901_avalon_slave_0_grant_vector;
  --opencores_i2c_jy901_avalon_slave_0_end_xfer assignment, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_end_xfer <= NOT ((opencores_i2c_jy901_avalon_slave_0_waits_for_read OR opencores_i2c_jy901_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_opencores_i2c_jy901_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_opencores_i2c_jy901_avalon_slave_0 <= opencores_i2c_jy901_avalon_slave_0_end_xfer AND (((NOT opencores_i2c_jy901_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --opencores_i2c_jy901_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_opencores_i2c_jy901_avalon_slave_0 AND opencores_i2c_jy901_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_opencores_i2c_jy901_avalon_slave_0 AND NOT opencores_i2c_jy901_avalon_slave_0_non_bursting_master_requests));
  --opencores_i2c_jy901_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      opencores_i2c_jy901_avalon_slave_0_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(opencores_i2c_jy901_avalon_slave_0_arb_counter_enable) = '1' then 
        opencores_i2c_jy901_avalon_slave_0_arb_share_counter <= opencores_i2c_jy901_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((opencores_i2c_jy901_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_opencores_i2c_jy901_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_opencores_i2c_jy901_avalon_slave_0 AND NOT opencores_i2c_jy901_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable <= or_reduce(opencores_i2c_jy901_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master opencores_i2c_jy901/avalon_slave_0 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(opencores_i2c_jy901_avalon_slave_0_arb_share_counter_next_value);
  --cpu_0/data_master opencores_i2c_jy901/avalon_slave_0 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --opencores_i2c_jy901_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 <= internal_cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0, which is an e_mux
  cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 <= (internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 AND cpu_0_data_master_read) AND NOT opencores_i2c_jy901_avalon_slave_0_waits_for_read;
  --opencores_i2c_jy901_avalon_slave_0_writedata mux, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_writedata <= cpu_0_data_master_writedata (7 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0;
  --cpu_0/data_master saved-grant opencores_i2c_jy901/avalon_slave_0, which is an e_assign
  cpu_0_data_master_saved_grant_opencores_i2c_jy901_avalon_slave_0 <= internal_cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0;
  --allow new arb cycle for opencores_i2c_jy901/avalon_slave_0, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  opencores_i2c_jy901_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  opencores_i2c_jy901_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~opencores_i2c_jy901_avalon_slave_0_reset assignment, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_reset <= NOT reset_n;
  opencores_i2c_jy901_avalon_slave_0_chipselect <= internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0;
  --opencores_i2c_jy901_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(opencores_i2c_jy901_avalon_slave_0_begins_xfer) = '1'), opencores_i2c_jy901_avalon_slave_0_unreg_firsttransfer, opencores_i2c_jy901_avalon_slave_0_reg_firsttransfer);
  --opencores_i2c_jy901_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_unreg_firsttransfer <= NOT ((opencores_i2c_jy901_avalon_slave_0_slavearbiterlockenable AND opencores_i2c_jy901_avalon_slave_0_any_continuerequest));
  --opencores_i2c_jy901_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      opencores_i2c_jy901_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(opencores_i2c_jy901_avalon_slave_0_begins_xfer) = '1' then 
        opencores_i2c_jy901_avalon_slave_0_reg_firsttransfer <= opencores_i2c_jy901_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --opencores_i2c_jy901_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_beginbursttransfer_internal <= opencores_i2c_jy901_avalon_slave_0_begins_xfer;
  --opencores_i2c_jy901_avalon_slave_0_write assignment, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_write <= ((internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 AND cpu_0_data_master_write)) AND opencores_i2c_jy901_avalon_slave_0_pretend_byte_enable;
  shifted_address_to_opencores_i2c_jy901_avalon_slave_0_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --opencores_i2c_jy901_avalon_slave_0_address mux, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_opencores_i2c_jy901_avalon_slave_0_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_opencores_i2c_jy901_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_opencores_i2c_jy901_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_opencores_i2c_jy901_avalon_slave_0_end_xfer <= opencores_i2c_jy901_avalon_slave_0_end_xfer;
    end if;

  end process;

  --opencores_i2c_jy901_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_waits_for_read <= opencores_i2c_jy901_avalon_slave_0_in_a_read_cycle AND NOT internal_opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa;
  --opencores_i2c_jy901_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_in_a_read_cycle <= internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= opencores_i2c_jy901_avalon_slave_0_in_a_read_cycle;
  --opencores_i2c_jy901_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_waits_for_write <= opencores_i2c_jy901_avalon_slave_0_in_a_write_cycle AND NOT internal_opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa;
  --opencores_i2c_jy901_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_in_a_write_cycle <= internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= opencores_i2c_jy901_avalon_slave_0_in_a_write_cycle;
  wait_for_opencores_i2c_jy901_avalon_slave_0_counter <= std_logic'('0');
  --opencores_i2c_jy901_avalon_slave_0_pretend_byte_enable byte enable port mux, which is an e_mux
  opencores_i2c_jy901_avalon_slave_0_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_0_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  --assign opencores_i2c_jy901_avalon_slave_0_irq_from_sa = opencores_i2c_jy901_avalon_slave_0_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  opencores_i2c_jy901_avalon_slave_0_irq_from_sa <= opencores_i2c_jy901_avalon_slave_0_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 <= internal_cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 <= internal_cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0;
  --vhdl renameroo for output signals
  opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa <= internal_opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa;
--synthesis translate_off
    --opencores_i2c_jy901/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pio_0_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal pio_0_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_pio_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_0_s1 : OUT STD_LOGIC;
                 signal d1_pio_0_s1_end_xfer : OUT STD_LOGIC;
                 signal pio_0_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal pio_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_0_s1_reset_n : OUT STD_LOGIC
              );
end entity pio_0_s1_arbitrator;


architecture europa of pio_0_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_pio_0_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pio_0_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_pio_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_pio_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_pio_0_s1 :  STD_LOGIC;
                signal pio_0_s1_allgrants :  STD_LOGIC;
                signal pio_0_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal pio_0_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pio_0_s1_any_continuerequest :  STD_LOGIC;
                signal pio_0_s1_arb_counter_enable :  STD_LOGIC;
                signal pio_0_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_0_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_0_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_0_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal pio_0_s1_begins_xfer :  STD_LOGIC;
                signal pio_0_s1_end_xfer :  STD_LOGIC;
                signal pio_0_s1_firsttransfer :  STD_LOGIC;
                signal pio_0_s1_grant_vector :  STD_LOGIC;
                signal pio_0_s1_in_a_read_cycle :  STD_LOGIC;
                signal pio_0_s1_in_a_write_cycle :  STD_LOGIC;
                signal pio_0_s1_master_qreq_vector :  STD_LOGIC;
                signal pio_0_s1_non_bursting_master_requests :  STD_LOGIC;
                signal pio_0_s1_reg_firsttransfer :  STD_LOGIC;
                signal pio_0_s1_slavearbiterlockenable :  STD_LOGIC;
                signal pio_0_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal pio_0_s1_unreg_firsttransfer :  STD_LOGIC;
                signal pio_0_s1_waits_for_read :  STD_LOGIC;
                signal pio_0_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pio_0_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_pio_0_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pio_0_s1_end_xfer;
    end if;

  end process;

  pio_0_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_pio_0_s1);
  --assign pio_0_s1_readdata_from_sa = pio_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pio_0_s1_readdata_from_sa <= pio_0_s1_readdata;
  internal_cpu_0_data_master_requests_pio_0_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000000100000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write)))) AND cpu_0_data_master_read;
  --pio_0_s1_arb_share_counter set values, which is an e_mux
  pio_0_s1_arb_share_set_values <= std_logic_vector'("001");
  --pio_0_s1_non_bursting_master_requests mux, which is an e_mux
  pio_0_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_pio_0_s1;
  --pio_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  pio_0_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --pio_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  pio_0_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pio_0_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_0_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pio_0_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_0_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --pio_0_s1_allgrants all slave grants, which is an e_mux
  pio_0_s1_allgrants <= pio_0_s1_grant_vector;
  --pio_0_s1_end_xfer assignment, which is an e_assign
  pio_0_s1_end_xfer <= NOT ((pio_0_s1_waits_for_read OR pio_0_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_pio_0_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pio_0_s1 <= pio_0_s1_end_xfer AND (((NOT pio_0_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pio_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  pio_0_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pio_0_s1 AND pio_0_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_pio_0_s1 AND NOT pio_0_s1_non_bursting_master_requests));
  --pio_0_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_0_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(pio_0_s1_arb_counter_enable) = '1' then 
        pio_0_s1_arb_share_counter <= pio_0_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pio_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_0_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pio_0_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_pio_0_s1)) OR ((end_xfer_arb_share_counter_term_pio_0_s1 AND NOT pio_0_s1_non_bursting_master_requests)))) = '1' then 
        pio_0_s1_slavearbiterlockenable <= or_reduce(pio_0_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master pio_0/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= pio_0_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --pio_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pio_0_s1_slavearbiterlockenable2 <= or_reduce(pio_0_s1_arb_share_counter_next_value);
  --cpu_0/data_master pio_0/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= pio_0_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --pio_0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  pio_0_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_pio_0_s1 <= internal_cpu_0_data_master_requests_pio_0_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_pio_0_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_pio_0_s1 <= (internal_cpu_0_data_master_granted_pio_0_s1 AND cpu_0_data_master_read) AND NOT pio_0_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_pio_0_s1 <= internal_cpu_0_data_master_qualified_request_pio_0_s1;
  --cpu_0/data_master saved-grant pio_0/s1, which is an e_assign
  cpu_0_data_master_saved_grant_pio_0_s1 <= internal_cpu_0_data_master_requests_pio_0_s1;
  --allow new arb cycle for pio_0/s1, which is an e_assign
  pio_0_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pio_0_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pio_0_s1_master_qreq_vector <= std_logic'('1');
  --pio_0_s1_reset_n assignment, which is an e_assign
  pio_0_s1_reset_n <= reset_n;
  --pio_0_s1_firsttransfer first transaction, which is an e_assign
  pio_0_s1_firsttransfer <= A_WE_StdLogic((std_logic'(pio_0_s1_begins_xfer) = '1'), pio_0_s1_unreg_firsttransfer, pio_0_s1_reg_firsttransfer);
  --pio_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  pio_0_s1_unreg_firsttransfer <= NOT ((pio_0_s1_slavearbiterlockenable AND pio_0_s1_any_continuerequest));
  --pio_0_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_0_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pio_0_s1_begins_xfer) = '1' then 
        pio_0_s1_reg_firsttransfer <= pio_0_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pio_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pio_0_s1_beginbursttransfer_internal <= pio_0_s1_begins_xfer;
  shifted_address_to_pio_0_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --pio_0_s1_address mux, which is an e_mux
  pio_0_s1_address <= A_EXT (A_SRL(shifted_address_to_pio_0_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_pio_0_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pio_0_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pio_0_s1_end_xfer <= pio_0_s1_end_xfer;
    end if;

  end process;

  --pio_0_s1_waits_for_read in a cycle, which is an e_mux
  pio_0_s1_waits_for_read <= pio_0_s1_in_a_read_cycle AND pio_0_s1_begins_xfer;
  --pio_0_s1_in_a_read_cycle assignment, which is an e_assign
  pio_0_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_pio_0_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pio_0_s1_in_a_read_cycle;
  --pio_0_s1_waits_for_write in a cycle, which is an e_mux
  pio_0_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pio_0_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --pio_0_s1_in_a_write_cycle assignment, which is an e_assign
  pio_0_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_pio_0_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pio_0_s1_in_a_write_cycle;
  wait_for_pio_0_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_pio_0_s1 <= internal_cpu_0_data_master_granted_pio_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_pio_0_s1 <= internal_cpu_0_data_master_qualified_request_pio_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_pio_0_s1 <= internal_cpu_0_data_master_requests_pio_0_s1;
--synthesis translate_off
    --pio_0/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pio_1_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_1_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_pio_1_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_1_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_1_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_1_s1 : OUT STD_LOGIC;
                 signal d1_pio_1_s1_end_xfer : OUT STD_LOGIC;
                 signal pio_1_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal pio_1_s1_chipselect : OUT STD_LOGIC;
                 signal pio_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_1_s1_reset_n : OUT STD_LOGIC;
                 signal pio_1_s1_write_n : OUT STD_LOGIC;
                 signal pio_1_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity pio_1_s1_arbitrator;


architecture europa of pio_1_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_pio_1_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pio_1_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_pio_1_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_pio_1_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_pio_1_s1 :  STD_LOGIC;
                signal pio_1_s1_allgrants :  STD_LOGIC;
                signal pio_1_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal pio_1_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pio_1_s1_any_continuerequest :  STD_LOGIC;
                signal pio_1_s1_arb_counter_enable :  STD_LOGIC;
                signal pio_1_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_1_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_1_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_1_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal pio_1_s1_begins_xfer :  STD_LOGIC;
                signal pio_1_s1_end_xfer :  STD_LOGIC;
                signal pio_1_s1_firsttransfer :  STD_LOGIC;
                signal pio_1_s1_grant_vector :  STD_LOGIC;
                signal pio_1_s1_in_a_read_cycle :  STD_LOGIC;
                signal pio_1_s1_in_a_write_cycle :  STD_LOGIC;
                signal pio_1_s1_master_qreq_vector :  STD_LOGIC;
                signal pio_1_s1_non_bursting_master_requests :  STD_LOGIC;
                signal pio_1_s1_reg_firsttransfer :  STD_LOGIC;
                signal pio_1_s1_slavearbiterlockenable :  STD_LOGIC;
                signal pio_1_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal pio_1_s1_unreg_firsttransfer :  STD_LOGIC;
                signal pio_1_s1_waits_for_read :  STD_LOGIC;
                signal pio_1_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pio_1_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_pio_1_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pio_1_s1_end_xfer;
    end if;

  end process;

  pio_1_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_pio_1_s1);
  --assign pio_1_s1_readdata_from_sa = pio_1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pio_1_s1_readdata_from_sa <= pio_1_s1_readdata;
  internal_cpu_0_data_master_requests_pio_1_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000000110000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --pio_1_s1_arb_share_counter set values, which is an e_mux
  pio_1_s1_arb_share_set_values <= std_logic_vector'("001");
  --pio_1_s1_non_bursting_master_requests mux, which is an e_mux
  pio_1_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_pio_1_s1;
  --pio_1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  pio_1_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --pio_1_s1_arb_share_counter_next_value assignment, which is an e_assign
  pio_1_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pio_1_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_1_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pio_1_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_1_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --pio_1_s1_allgrants all slave grants, which is an e_mux
  pio_1_s1_allgrants <= pio_1_s1_grant_vector;
  --pio_1_s1_end_xfer assignment, which is an e_assign
  pio_1_s1_end_xfer <= NOT ((pio_1_s1_waits_for_read OR pio_1_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_pio_1_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pio_1_s1 <= pio_1_s1_end_xfer AND (((NOT pio_1_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pio_1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  pio_1_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pio_1_s1 AND pio_1_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_pio_1_s1 AND NOT pio_1_s1_non_bursting_master_requests));
  --pio_1_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_1_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(pio_1_s1_arb_counter_enable) = '1' then 
        pio_1_s1_arb_share_counter <= pio_1_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pio_1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_1_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pio_1_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_pio_1_s1)) OR ((end_xfer_arb_share_counter_term_pio_1_s1 AND NOT pio_1_s1_non_bursting_master_requests)))) = '1' then 
        pio_1_s1_slavearbiterlockenable <= or_reduce(pio_1_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master pio_1/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= pio_1_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --pio_1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pio_1_s1_slavearbiterlockenable2 <= or_reduce(pio_1_s1_arb_share_counter_next_value);
  --cpu_0/data_master pio_1/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= pio_1_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --pio_1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  pio_1_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_pio_1_s1 <= internal_cpu_0_data_master_requests_pio_1_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_pio_1_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_pio_1_s1 <= (internal_cpu_0_data_master_granted_pio_1_s1 AND cpu_0_data_master_read) AND NOT pio_1_s1_waits_for_read;
  --pio_1_s1_writedata mux, which is an e_mux
  pio_1_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_pio_1_s1 <= internal_cpu_0_data_master_qualified_request_pio_1_s1;
  --cpu_0/data_master saved-grant pio_1/s1, which is an e_assign
  cpu_0_data_master_saved_grant_pio_1_s1 <= internal_cpu_0_data_master_requests_pio_1_s1;
  --allow new arb cycle for pio_1/s1, which is an e_assign
  pio_1_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pio_1_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pio_1_s1_master_qreq_vector <= std_logic'('1');
  --pio_1_s1_reset_n assignment, which is an e_assign
  pio_1_s1_reset_n <= reset_n;
  pio_1_s1_chipselect <= internal_cpu_0_data_master_granted_pio_1_s1;
  --pio_1_s1_firsttransfer first transaction, which is an e_assign
  pio_1_s1_firsttransfer <= A_WE_StdLogic((std_logic'(pio_1_s1_begins_xfer) = '1'), pio_1_s1_unreg_firsttransfer, pio_1_s1_reg_firsttransfer);
  --pio_1_s1_unreg_firsttransfer first transaction, which is an e_assign
  pio_1_s1_unreg_firsttransfer <= NOT ((pio_1_s1_slavearbiterlockenable AND pio_1_s1_any_continuerequest));
  --pio_1_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_1_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pio_1_s1_begins_xfer) = '1' then 
        pio_1_s1_reg_firsttransfer <= pio_1_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pio_1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pio_1_s1_beginbursttransfer_internal <= pio_1_s1_begins_xfer;
  --~pio_1_s1_write_n assignment, which is an e_mux
  pio_1_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_pio_1_s1 AND cpu_0_data_master_write));
  shifted_address_to_pio_1_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --pio_1_s1_address mux, which is an e_mux
  pio_1_s1_address <= A_EXT (A_SRL(shifted_address_to_pio_1_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_pio_1_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pio_1_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pio_1_s1_end_xfer <= pio_1_s1_end_xfer;
    end if;

  end process;

  --pio_1_s1_waits_for_read in a cycle, which is an e_mux
  pio_1_s1_waits_for_read <= pio_1_s1_in_a_read_cycle AND pio_1_s1_begins_xfer;
  --pio_1_s1_in_a_read_cycle assignment, which is an e_assign
  pio_1_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_pio_1_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pio_1_s1_in_a_read_cycle;
  --pio_1_s1_waits_for_write in a cycle, which is an e_mux
  pio_1_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pio_1_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --pio_1_s1_in_a_write_cycle assignment, which is an e_assign
  pio_1_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_pio_1_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pio_1_s1_in_a_write_cycle;
  wait_for_pio_1_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_pio_1_s1 <= internal_cpu_0_data_master_granted_pio_1_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_pio_1_s1 <= internal_cpu_0_data_master_qualified_request_pio_1_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_pio_1_s1 <= internal_cpu_0_data_master_requests_pio_1_s1;
--synthesis translate_off
    --pio_1/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pio_2_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_pio_2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_2_s1 : OUT STD_LOGIC;
                 signal d1_pio_2_s1_end_xfer : OUT STD_LOGIC;
                 signal pio_2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal pio_2_s1_chipselect : OUT STD_LOGIC;
                 signal pio_2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_2_s1_reset_n : OUT STD_LOGIC;
                 signal pio_2_s1_write_n : OUT STD_LOGIC;
                 signal pio_2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity pio_2_s1_arbitrator;


architecture europa of pio_2_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_pio_2_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pio_2_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_pio_2_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_pio_2_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_pio_2_s1 :  STD_LOGIC;
                signal pio_2_s1_allgrants :  STD_LOGIC;
                signal pio_2_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal pio_2_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pio_2_s1_any_continuerequest :  STD_LOGIC;
                signal pio_2_s1_arb_counter_enable :  STD_LOGIC;
                signal pio_2_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_2_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_2_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_2_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal pio_2_s1_begins_xfer :  STD_LOGIC;
                signal pio_2_s1_end_xfer :  STD_LOGIC;
                signal pio_2_s1_firsttransfer :  STD_LOGIC;
                signal pio_2_s1_grant_vector :  STD_LOGIC;
                signal pio_2_s1_in_a_read_cycle :  STD_LOGIC;
                signal pio_2_s1_in_a_write_cycle :  STD_LOGIC;
                signal pio_2_s1_master_qreq_vector :  STD_LOGIC;
                signal pio_2_s1_non_bursting_master_requests :  STD_LOGIC;
                signal pio_2_s1_reg_firsttransfer :  STD_LOGIC;
                signal pio_2_s1_slavearbiterlockenable :  STD_LOGIC;
                signal pio_2_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal pio_2_s1_unreg_firsttransfer :  STD_LOGIC;
                signal pio_2_s1_waits_for_read :  STD_LOGIC;
                signal pio_2_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pio_2_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_pio_2_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pio_2_s1_end_xfer;
    end if;

  end process;

  pio_2_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_pio_2_s1);
  --assign pio_2_s1_readdata_from_sa = pio_2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pio_2_s1_readdata_from_sa <= pio_2_s1_readdata;
  internal_cpu_0_data_master_requests_pio_2_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000001100000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --pio_2_s1_arb_share_counter set values, which is an e_mux
  pio_2_s1_arb_share_set_values <= std_logic_vector'("001");
  --pio_2_s1_non_bursting_master_requests mux, which is an e_mux
  pio_2_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_pio_2_s1;
  --pio_2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  pio_2_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --pio_2_s1_arb_share_counter_next_value assignment, which is an e_assign
  pio_2_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pio_2_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_2_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pio_2_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_2_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --pio_2_s1_allgrants all slave grants, which is an e_mux
  pio_2_s1_allgrants <= pio_2_s1_grant_vector;
  --pio_2_s1_end_xfer assignment, which is an e_assign
  pio_2_s1_end_xfer <= NOT ((pio_2_s1_waits_for_read OR pio_2_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_pio_2_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pio_2_s1 <= pio_2_s1_end_xfer AND (((NOT pio_2_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pio_2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  pio_2_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pio_2_s1 AND pio_2_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_pio_2_s1 AND NOT pio_2_s1_non_bursting_master_requests));
  --pio_2_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_2_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(pio_2_s1_arb_counter_enable) = '1' then 
        pio_2_s1_arb_share_counter <= pio_2_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pio_2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_2_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pio_2_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_pio_2_s1)) OR ((end_xfer_arb_share_counter_term_pio_2_s1 AND NOT pio_2_s1_non_bursting_master_requests)))) = '1' then 
        pio_2_s1_slavearbiterlockenable <= or_reduce(pio_2_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master pio_2/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= pio_2_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --pio_2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pio_2_s1_slavearbiterlockenable2 <= or_reduce(pio_2_s1_arb_share_counter_next_value);
  --cpu_0/data_master pio_2/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= pio_2_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --pio_2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  pio_2_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_pio_2_s1 <= internal_cpu_0_data_master_requests_pio_2_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_pio_2_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_pio_2_s1 <= (internal_cpu_0_data_master_granted_pio_2_s1 AND cpu_0_data_master_read) AND NOT pio_2_s1_waits_for_read;
  --pio_2_s1_writedata mux, which is an e_mux
  pio_2_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_pio_2_s1 <= internal_cpu_0_data_master_qualified_request_pio_2_s1;
  --cpu_0/data_master saved-grant pio_2/s1, which is an e_assign
  cpu_0_data_master_saved_grant_pio_2_s1 <= internal_cpu_0_data_master_requests_pio_2_s1;
  --allow new arb cycle for pio_2/s1, which is an e_assign
  pio_2_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pio_2_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pio_2_s1_master_qreq_vector <= std_logic'('1');
  --pio_2_s1_reset_n assignment, which is an e_assign
  pio_2_s1_reset_n <= reset_n;
  pio_2_s1_chipselect <= internal_cpu_0_data_master_granted_pio_2_s1;
  --pio_2_s1_firsttransfer first transaction, which is an e_assign
  pio_2_s1_firsttransfer <= A_WE_StdLogic((std_logic'(pio_2_s1_begins_xfer) = '1'), pio_2_s1_unreg_firsttransfer, pio_2_s1_reg_firsttransfer);
  --pio_2_s1_unreg_firsttransfer first transaction, which is an e_assign
  pio_2_s1_unreg_firsttransfer <= NOT ((pio_2_s1_slavearbiterlockenable AND pio_2_s1_any_continuerequest));
  --pio_2_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_2_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pio_2_s1_begins_xfer) = '1' then 
        pio_2_s1_reg_firsttransfer <= pio_2_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pio_2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pio_2_s1_beginbursttransfer_internal <= pio_2_s1_begins_xfer;
  --~pio_2_s1_write_n assignment, which is an e_mux
  pio_2_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_pio_2_s1 AND cpu_0_data_master_write));
  shifted_address_to_pio_2_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --pio_2_s1_address mux, which is an e_mux
  pio_2_s1_address <= A_EXT (A_SRL(shifted_address_to_pio_2_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_pio_2_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pio_2_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pio_2_s1_end_xfer <= pio_2_s1_end_xfer;
    end if;

  end process;

  --pio_2_s1_waits_for_read in a cycle, which is an e_mux
  pio_2_s1_waits_for_read <= pio_2_s1_in_a_read_cycle AND pio_2_s1_begins_xfer;
  --pio_2_s1_in_a_read_cycle assignment, which is an e_assign
  pio_2_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_pio_2_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pio_2_s1_in_a_read_cycle;
  --pio_2_s1_waits_for_write in a cycle, which is an e_mux
  pio_2_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pio_2_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --pio_2_s1_in_a_write_cycle assignment, which is an e_assign
  pio_2_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_pio_2_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pio_2_s1_in_a_write_cycle;
  wait_for_pio_2_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_pio_2_s1 <= internal_cpu_0_data_master_granted_pio_2_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_pio_2_s1 <= internal_cpu_0_data_master_qualified_request_pio_2_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_pio_2_s1 <= internal_cpu_0_data_master_requests_pio_2_s1;
--synthesis translate_off
    --pio_2/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pio_3_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_pio_3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_3_s1 : OUT STD_LOGIC;
                 signal d1_pio_3_s1_end_xfer : OUT STD_LOGIC;
                 signal pio_3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal pio_3_s1_chipselect : OUT STD_LOGIC;
                 signal pio_3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_3_s1_reset_n : OUT STD_LOGIC;
                 signal pio_3_s1_write_n : OUT STD_LOGIC;
                 signal pio_3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity pio_3_s1_arbitrator;


architecture europa of pio_3_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_pio_3_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pio_3_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_pio_3_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_pio_3_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_pio_3_s1 :  STD_LOGIC;
                signal pio_3_s1_allgrants :  STD_LOGIC;
                signal pio_3_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal pio_3_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pio_3_s1_any_continuerequest :  STD_LOGIC;
                signal pio_3_s1_arb_counter_enable :  STD_LOGIC;
                signal pio_3_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_3_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_3_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_3_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal pio_3_s1_begins_xfer :  STD_LOGIC;
                signal pio_3_s1_end_xfer :  STD_LOGIC;
                signal pio_3_s1_firsttransfer :  STD_LOGIC;
                signal pio_3_s1_grant_vector :  STD_LOGIC;
                signal pio_3_s1_in_a_read_cycle :  STD_LOGIC;
                signal pio_3_s1_in_a_write_cycle :  STD_LOGIC;
                signal pio_3_s1_master_qreq_vector :  STD_LOGIC;
                signal pio_3_s1_non_bursting_master_requests :  STD_LOGIC;
                signal pio_3_s1_reg_firsttransfer :  STD_LOGIC;
                signal pio_3_s1_slavearbiterlockenable :  STD_LOGIC;
                signal pio_3_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal pio_3_s1_unreg_firsttransfer :  STD_LOGIC;
                signal pio_3_s1_waits_for_read :  STD_LOGIC;
                signal pio_3_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pio_3_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_pio_3_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pio_3_s1_end_xfer;
    end if;

  end process;

  pio_3_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_pio_3_s1);
  --assign pio_3_s1_readdata_from_sa = pio_3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pio_3_s1_readdata_from_sa <= pio_3_s1_readdata;
  internal_cpu_0_data_master_requests_pio_3_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000001110000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --pio_3_s1_arb_share_counter set values, which is an e_mux
  pio_3_s1_arb_share_set_values <= std_logic_vector'("001");
  --pio_3_s1_non_bursting_master_requests mux, which is an e_mux
  pio_3_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_pio_3_s1;
  --pio_3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  pio_3_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --pio_3_s1_arb_share_counter_next_value assignment, which is an e_assign
  pio_3_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pio_3_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_3_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pio_3_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_3_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --pio_3_s1_allgrants all slave grants, which is an e_mux
  pio_3_s1_allgrants <= pio_3_s1_grant_vector;
  --pio_3_s1_end_xfer assignment, which is an e_assign
  pio_3_s1_end_xfer <= NOT ((pio_3_s1_waits_for_read OR pio_3_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_pio_3_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pio_3_s1 <= pio_3_s1_end_xfer AND (((NOT pio_3_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pio_3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  pio_3_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pio_3_s1 AND pio_3_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_pio_3_s1 AND NOT pio_3_s1_non_bursting_master_requests));
  --pio_3_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_3_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(pio_3_s1_arb_counter_enable) = '1' then 
        pio_3_s1_arb_share_counter <= pio_3_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pio_3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_3_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pio_3_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_pio_3_s1)) OR ((end_xfer_arb_share_counter_term_pio_3_s1 AND NOT pio_3_s1_non_bursting_master_requests)))) = '1' then 
        pio_3_s1_slavearbiterlockenable <= or_reduce(pio_3_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master pio_3/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= pio_3_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --pio_3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pio_3_s1_slavearbiterlockenable2 <= or_reduce(pio_3_s1_arb_share_counter_next_value);
  --cpu_0/data_master pio_3/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= pio_3_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --pio_3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  pio_3_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_pio_3_s1 <= internal_cpu_0_data_master_requests_pio_3_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_pio_3_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_pio_3_s1 <= (internal_cpu_0_data_master_granted_pio_3_s1 AND cpu_0_data_master_read) AND NOT pio_3_s1_waits_for_read;
  --pio_3_s1_writedata mux, which is an e_mux
  pio_3_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_pio_3_s1 <= internal_cpu_0_data_master_qualified_request_pio_3_s1;
  --cpu_0/data_master saved-grant pio_3/s1, which is an e_assign
  cpu_0_data_master_saved_grant_pio_3_s1 <= internal_cpu_0_data_master_requests_pio_3_s1;
  --allow new arb cycle for pio_3/s1, which is an e_assign
  pio_3_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pio_3_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pio_3_s1_master_qreq_vector <= std_logic'('1');
  --pio_3_s1_reset_n assignment, which is an e_assign
  pio_3_s1_reset_n <= reset_n;
  pio_3_s1_chipselect <= internal_cpu_0_data_master_granted_pio_3_s1;
  --pio_3_s1_firsttransfer first transaction, which is an e_assign
  pio_3_s1_firsttransfer <= A_WE_StdLogic((std_logic'(pio_3_s1_begins_xfer) = '1'), pio_3_s1_unreg_firsttransfer, pio_3_s1_reg_firsttransfer);
  --pio_3_s1_unreg_firsttransfer first transaction, which is an e_assign
  pio_3_s1_unreg_firsttransfer <= NOT ((pio_3_s1_slavearbiterlockenable AND pio_3_s1_any_continuerequest));
  --pio_3_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_3_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pio_3_s1_begins_xfer) = '1' then 
        pio_3_s1_reg_firsttransfer <= pio_3_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pio_3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pio_3_s1_beginbursttransfer_internal <= pio_3_s1_begins_xfer;
  --~pio_3_s1_write_n assignment, which is an e_mux
  pio_3_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_pio_3_s1 AND cpu_0_data_master_write));
  shifted_address_to_pio_3_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --pio_3_s1_address mux, which is an e_mux
  pio_3_s1_address <= A_EXT (A_SRL(shifted_address_to_pio_3_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_pio_3_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pio_3_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pio_3_s1_end_xfer <= pio_3_s1_end_xfer;
    end if;

  end process;

  --pio_3_s1_waits_for_read in a cycle, which is an e_mux
  pio_3_s1_waits_for_read <= pio_3_s1_in_a_read_cycle AND pio_3_s1_begins_xfer;
  --pio_3_s1_in_a_read_cycle assignment, which is an e_assign
  pio_3_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_pio_3_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pio_3_s1_in_a_read_cycle;
  --pio_3_s1_waits_for_write in a cycle, which is an e_mux
  pio_3_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pio_3_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --pio_3_s1_in_a_write_cycle assignment, which is an e_assign
  pio_3_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_pio_3_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pio_3_s1_in_a_write_cycle;
  wait_for_pio_3_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_pio_3_s1 <= internal_cpu_0_data_master_granted_pio_3_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_pio_3_s1 <= internal_cpu_0_data_master_qualified_request_pio_3_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_pio_3_s1 <= internal_cpu_0_data_master_requests_pio_3_s1;
--synthesis translate_off
    --pio_3/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pio_4_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_pio_4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_pio_4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_pio_4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_pio_4_s1 : OUT STD_LOGIC;
                 signal d1_pio_4_s1_end_xfer : OUT STD_LOGIC;
                 signal pio_4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal pio_4_s1_chipselect : OUT STD_LOGIC;
                 signal pio_4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pio_4_s1_reset_n : OUT STD_LOGIC;
                 signal pio_4_s1_write_n : OUT STD_LOGIC;
                 signal pio_4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity pio_4_s1_arbitrator;


architecture europa of pio_4_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_pio_4_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pio_4_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_pio_4_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_pio_4_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_pio_4_s1 :  STD_LOGIC;
                signal pio_4_s1_allgrants :  STD_LOGIC;
                signal pio_4_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal pio_4_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pio_4_s1_any_continuerequest :  STD_LOGIC;
                signal pio_4_s1_arb_counter_enable :  STD_LOGIC;
                signal pio_4_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_4_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_4_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal pio_4_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal pio_4_s1_begins_xfer :  STD_LOGIC;
                signal pio_4_s1_end_xfer :  STD_LOGIC;
                signal pio_4_s1_firsttransfer :  STD_LOGIC;
                signal pio_4_s1_grant_vector :  STD_LOGIC;
                signal pio_4_s1_in_a_read_cycle :  STD_LOGIC;
                signal pio_4_s1_in_a_write_cycle :  STD_LOGIC;
                signal pio_4_s1_master_qreq_vector :  STD_LOGIC;
                signal pio_4_s1_non_bursting_master_requests :  STD_LOGIC;
                signal pio_4_s1_reg_firsttransfer :  STD_LOGIC;
                signal pio_4_s1_slavearbiterlockenable :  STD_LOGIC;
                signal pio_4_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal pio_4_s1_unreg_firsttransfer :  STD_LOGIC;
                signal pio_4_s1_waits_for_read :  STD_LOGIC;
                signal pio_4_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pio_4_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_pio_4_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pio_4_s1_end_xfer;
    end if;

  end process;

  pio_4_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_pio_4_s1);
  --assign pio_4_s1_readdata_from_sa = pio_4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pio_4_s1_readdata_from_sa <= pio_4_s1_readdata;
  internal_cpu_0_data_master_requests_pio_4_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000010000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --pio_4_s1_arb_share_counter set values, which is an e_mux
  pio_4_s1_arb_share_set_values <= std_logic_vector'("001");
  --pio_4_s1_non_bursting_master_requests mux, which is an e_mux
  pio_4_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_pio_4_s1;
  --pio_4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  pio_4_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --pio_4_s1_arb_share_counter_next_value assignment, which is an e_assign
  pio_4_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(pio_4_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_4_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(pio_4_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (pio_4_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --pio_4_s1_allgrants all slave grants, which is an e_mux
  pio_4_s1_allgrants <= pio_4_s1_grant_vector;
  --pio_4_s1_end_xfer assignment, which is an e_assign
  pio_4_s1_end_xfer <= NOT ((pio_4_s1_waits_for_read OR pio_4_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_pio_4_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pio_4_s1 <= pio_4_s1_end_xfer AND (((NOT pio_4_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pio_4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  pio_4_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pio_4_s1 AND pio_4_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_pio_4_s1 AND NOT pio_4_s1_non_bursting_master_requests));
  --pio_4_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_4_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(pio_4_s1_arb_counter_enable) = '1' then 
        pio_4_s1_arb_share_counter <= pio_4_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pio_4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_4_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pio_4_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_pio_4_s1)) OR ((end_xfer_arb_share_counter_term_pio_4_s1 AND NOT pio_4_s1_non_bursting_master_requests)))) = '1' then 
        pio_4_s1_slavearbiterlockenable <= or_reduce(pio_4_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master pio_4/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= pio_4_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --pio_4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pio_4_s1_slavearbiterlockenable2 <= or_reduce(pio_4_s1_arb_share_counter_next_value);
  --cpu_0/data_master pio_4/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= pio_4_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --pio_4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  pio_4_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_pio_4_s1 <= internal_cpu_0_data_master_requests_pio_4_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_pio_4_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_pio_4_s1 <= (internal_cpu_0_data_master_granted_pio_4_s1 AND cpu_0_data_master_read) AND NOT pio_4_s1_waits_for_read;
  --pio_4_s1_writedata mux, which is an e_mux
  pio_4_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_pio_4_s1 <= internal_cpu_0_data_master_qualified_request_pio_4_s1;
  --cpu_0/data_master saved-grant pio_4/s1, which is an e_assign
  cpu_0_data_master_saved_grant_pio_4_s1 <= internal_cpu_0_data_master_requests_pio_4_s1;
  --allow new arb cycle for pio_4/s1, which is an e_assign
  pio_4_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pio_4_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pio_4_s1_master_qreq_vector <= std_logic'('1');
  --pio_4_s1_reset_n assignment, which is an e_assign
  pio_4_s1_reset_n <= reset_n;
  pio_4_s1_chipselect <= internal_cpu_0_data_master_granted_pio_4_s1;
  --pio_4_s1_firsttransfer first transaction, which is an e_assign
  pio_4_s1_firsttransfer <= A_WE_StdLogic((std_logic'(pio_4_s1_begins_xfer) = '1'), pio_4_s1_unreg_firsttransfer, pio_4_s1_reg_firsttransfer);
  --pio_4_s1_unreg_firsttransfer first transaction, which is an e_assign
  pio_4_s1_unreg_firsttransfer <= NOT ((pio_4_s1_slavearbiterlockenable AND pio_4_s1_any_continuerequest));
  --pio_4_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pio_4_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pio_4_s1_begins_xfer) = '1' then 
        pio_4_s1_reg_firsttransfer <= pio_4_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pio_4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pio_4_s1_beginbursttransfer_internal <= pio_4_s1_begins_xfer;
  --~pio_4_s1_write_n assignment, which is an e_mux
  pio_4_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_pio_4_s1 AND cpu_0_data_master_write));
  shifted_address_to_pio_4_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --pio_4_s1_address mux, which is an e_mux
  pio_4_s1_address <= A_EXT (A_SRL(shifted_address_to_pio_4_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_pio_4_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pio_4_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pio_4_s1_end_xfer <= pio_4_s1_end_xfer;
    end if;

  end process;

  --pio_4_s1_waits_for_read in a cycle, which is an e_mux
  pio_4_s1_waits_for_read <= pio_4_s1_in_a_read_cycle AND pio_4_s1_begins_xfer;
  --pio_4_s1_in_a_read_cycle assignment, which is an e_assign
  pio_4_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_pio_4_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pio_4_s1_in_a_read_cycle;
  --pio_4_s1_waits_for_write in a cycle, which is an e_mux
  pio_4_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pio_4_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --pio_4_s1_in_a_write_cycle assignment, which is an e_assign
  pio_4_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_pio_4_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pio_4_s1_in_a_write_cycle;
  wait_for_pio_4_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_pio_4_s1 <= internal_cpu_0_data_master_granted_pio_4_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_pio_4_s1 <= internal_cpu_0_data_master_qualified_request_pio_4_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_pio_4_s1 <= internal_cpu_0_data_master_requests_pio_4_s1;
--synthesis translate_off
    --pio_4/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module;


architecture europa of rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module;


architecture europa of rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity sdram_0_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_0_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_readdatavalid : IN STD_LOGIC;
                 signal sdram_0_s1_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_byteenable_sdram_0_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                 signal d1_sdram_0_s1_end_xfer : OUT STD_LOGIC;
                 signal sdram_0_s1_address : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                 signal sdram_0_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal sdram_0_s1_chipselect : OUT STD_LOGIC;
                 signal sdram_0_s1_read_n : OUT STD_LOGIC;
                 signal sdram_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_reset_n : OUT STD_LOGIC;
                 signal sdram_0_s1_waitrequest_from_sa : OUT STD_LOGIC;
                 signal sdram_0_s1_write_n : OUT STD_LOGIC;
                 signal sdram_0_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity sdram_0_s1_arbitrator;


architecture europa of sdram_0_s1_arbitrator is
component rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module;

component rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module;

                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_sdram_0_s1_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_byteenable_sdram_0_s1_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_rdv_fifo_empty_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_saved_grant_sdram_0_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sdram_0_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_byteenable_sdram_0_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_data_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal internal_sdram_0_s1_waitrequest_from_sa :  STD_LOGIC;
                signal last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 :  STD_LOGIC;
                signal last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal sdram_0_s1_allgrants :  STD_LOGIC;
                signal sdram_0_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal sdram_0_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sdram_0_s1_any_continuerequest :  STD_LOGIC;
                signal sdram_0_s1_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_arb_counter_enable :  STD_LOGIC;
                signal sdram_0_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_0_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_0_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_0_s1_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal sdram_0_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal sdram_0_s1_begins_xfer :  STD_LOGIC;
                signal sdram_0_s1_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal sdram_0_s1_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_end_xfer :  STD_LOGIC;
                signal sdram_0_s1_firsttransfer :  STD_LOGIC;
                signal sdram_0_s1_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_in_a_read_cycle :  STD_LOGIC;
                signal sdram_0_s1_in_a_write_cycle :  STD_LOGIC;
                signal sdram_0_s1_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_move_on_to_next_transaction :  STD_LOGIC;
                signal sdram_0_s1_non_bursting_master_requests :  STD_LOGIC;
                signal sdram_0_s1_readdatavalid_from_sa :  STD_LOGIC;
                signal sdram_0_s1_reg_firsttransfer :  STD_LOGIC;
                signal sdram_0_s1_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_slavearbiterlockenable :  STD_LOGIC;
                signal sdram_0_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal sdram_0_s1_unreg_firsttransfer :  STD_LOGIC;
                signal sdram_0_s1_waits_for_read :  STD_LOGIC;
                signal sdram_0_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_sdram_0_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_sdram_0_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sdram_0_s1_end_xfer;
    end if;

  end process;

  sdram_0_s1_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_0_data_master_qualified_request_sdram_0_s1 OR internal_cpu_0_instruction_master_qualified_request_sdram_0_s1));
  --assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_0_s1_readdatavalid_from_sa <= sdram_0_s1_readdatavalid;
  --assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_0_s1_readdata_from_sa <= sdram_0_s1_readdata;
  internal_cpu_0_data_master_requests_sdram_0_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 25) & std_logic_vector'("0000000000000000000000000")) = std_logic_vector'("010000000000000000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_sdram_0_s1_waitrequest_from_sa <= sdram_0_s1_waitrequest;
  --sdram_0_s1_arb_share_counter set values, which is an e_mux
  sdram_0_s1_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_instruction_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_instruction_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001"))))), 3);
  --sdram_0_s1_non_bursting_master_requests mux, which is an e_mux
  sdram_0_s1_non_bursting_master_requests <= ((internal_cpu_0_data_master_requests_sdram_0_s1 OR internal_cpu_0_instruction_master_requests_sdram_0_s1) OR internal_cpu_0_data_master_requests_sdram_0_s1) OR internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --sdram_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  sdram_0_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --sdram_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  sdram_0_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sdram_0_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_0_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sdram_0_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_0_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --sdram_0_s1_allgrants all slave grants, which is an e_mux
  sdram_0_s1_allgrants <= (((or_reduce(sdram_0_s1_grant_vector)) OR (or_reduce(sdram_0_s1_grant_vector))) OR (or_reduce(sdram_0_s1_grant_vector))) OR (or_reduce(sdram_0_s1_grant_vector));
  --sdram_0_s1_end_xfer assignment, which is an e_assign
  sdram_0_s1_end_xfer <= NOT ((sdram_0_s1_waits_for_read OR sdram_0_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_sdram_0_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sdram_0_s1 <= sdram_0_s1_end_xfer AND (((NOT sdram_0_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sdram_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  sdram_0_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sdram_0_s1 AND sdram_0_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_sdram_0_s1 AND NOT sdram_0_s1_non_bursting_master_requests));
  --sdram_0_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_0_s1_arb_counter_enable) = '1' then 
        sdram_0_s1_arb_share_counter <= sdram_0_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sdram_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(sdram_0_s1_master_qreq_vector) AND end_xfer_arb_share_counter_term_sdram_0_s1)) OR ((end_xfer_arb_share_counter_term_sdram_0_s1 AND NOT sdram_0_s1_non_bursting_master_requests)))) = '1' then 
        sdram_0_s1_slavearbiterlockenable <= or_reduce(sdram_0_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master sdram_0/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= sdram_0_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --sdram_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sdram_0_s1_slavearbiterlockenable2 <= or_reduce(sdram_0_s1_arb_share_counter_next_value);
  --cpu_0/data_master sdram_0/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= sdram_0_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --cpu_0/instruction_master sdram_0/s1 arbiterlock, which is an e_assign
  cpu_0_instruction_master_arbiterlock <= sdram_0_s1_slavearbiterlockenable AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master sdram_0/s1 arbiterlock2, which is an e_assign
  cpu_0_instruction_master_arbiterlock2 <= sdram_0_s1_slavearbiterlockenable2 AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master granted sdram_0/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_instruction_master_saved_grant_sdram_0_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_0_s1_arbitration_holdoff_internal OR NOT internal_cpu_0_instruction_master_requests_sdram_0_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1))))));
    end if;

  end process;

  --cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  cpu_0_instruction_master_continuerequest <= last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 AND internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --sdram_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  sdram_0_s1_any_continuerequest <= cpu_0_instruction_master_continuerequest OR cpu_0_data_master_continuerequest;
  internal_cpu_0_data_master_qualified_request_sdram_0_s1 <= internal_cpu_0_data_master_requests_sdram_0_s1 AND NOT (((((cpu_0_data_master_read AND to_std_logic((((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter))))))))) OR (((NOT(or_reduce(internal_cpu_0_data_master_byteenable_sdram_0_s1))) AND cpu_0_data_master_write))) OR cpu_0_instruction_master_arbiterlock));
  --unique name for sdram_0_s1_move_on_to_next_transaction, which is an e_assign
  sdram_0_s1_move_on_to_next_transaction <= sdram_0_s1_readdatavalid_from_sa;
  --rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1 : rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module
    port map(
      data_out => cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1,
      empty => open,
      fifo_contains_ones_n => cpu_0_data_master_rdv_fifo_empty_sdram_0_s1,
      full => open,
      clear_fifo => module_input,
      clk => clk,
      data_in => internal_cpu_0_data_master_granted_sdram_0_s1,
      read => sdram_0_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input1,
      write => module_input2
    );

  module_input <= std_logic'('0');
  module_input1 <= std_logic'('0');
  module_input2 <= in_a_read_cycle AND NOT sdram_0_s1_waits_for_read;

  cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register <= NOT cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  --local readdatavalid cpu_0_data_master_read_data_valid_sdram_0_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_sdram_0_s1 <= ((sdram_0_s1_readdatavalid_from_sa AND cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1)) AND NOT cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  --sdram_0_s1_writedata mux, which is an e_mux
  sdram_0_s1_writedata <= cpu_0_data_master_dbs_write_16;
  internal_cpu_0_instruction_master_requests_sdram_0_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_instruction_master_address_to_slave(26 DOWNTO 25) & std_logic_vector'("0000000000000000000000000")) = std_logic_vector'("010000000000000000000000000")))) AND (cpu_0_instruction_master_read))) AND cpu_0_instruction_master_read;
  --cpu_0/data_master granted sdram_0/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_data_master_saved_grant_sdram_0_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_0_s1_arbitration_holdoff_internal OR NOT internal_cpu_0_data_master_requests_sdram_0_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1))))));
    end if;

  end process;

  --cpu_0_data_master_continuerequest continued request, which is an e_mux
  cpu_0_data_master_continuerequest <= last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 AND internal_cpu_0_data_master_requests_sdram_0_s1;
  internal_cpu_0_instruction_master_qualified_request_sdram_0_s1 <= internal_cpu_0_instruction_master_requests_sdram_0_s1 AND NOT ((((cpu_0_instruction_master_read AND to_std_logic((((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("000000000000000000000000000000") & (cpu_0_instruction_master_latency_counter))))))))) OR cpu_0_data_master_arbiterlock));
  --rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1 : rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module
    port map(
      data_out => cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1,
      empty => open,
      fifo_contains_ones_n => cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1,
      full => open,
      clear_fifo => module_input3,
      clk => clk,
      data_in => internal_cpu_0_instruction_master_granted_sdram_0_s1,
      read => sdram_0_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input4,
      write => module_input5
    );

  module_input3 <= std_logic'('0');
  module_input4 <= std_logic'('0');
  module_input5 <= in_a_read_cycle AND NOT sdram_0_s1_waits_for_read;

  cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register <= NOT cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  --local readdatavalid cpu_0_instruction_master_read_data_valid_sdram_0_s1, which is an e_mux
  cpu_0_instruction_master_read_data_valid_sdram_0_s1 <= ((sdram_0_s1_readdatavalid_from_sa AND cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1)) AND NOT cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  --allow new arb cycle for sdram_0/s1, which is an e_assign
  sdram_0_s1_allow_new_arb_cycle <= NOT cpu_0_data_master_arbiterlock AND NOT cpu_0_instruction_master_arbiterlock;
  --cpu_0/instruction_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  sdram_0_s1_master_qreq_vector(0) <= internal_cpu_0_instruction_master_qualified_request_sdram_0_s1;
  --cpu_0/instruction_master grant sdram_0/s1, which is an e_assign
  internal_cpu_0_instruction_master_granted_sdram_0_s1 <= sdram_0_s1_grant_vector(0);
  --cpu_0/instruction_master saved-grant sdram_0/s1, which is an e_assign
  cpu_0_instruction_master_saved_grant_sdram_0_s1 <= sdram_0_s1_arb_winner(0) AND internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --cpu_0/data_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  sdram_0_s1_master_qreq_vector(1) <= internal_cpu_0_data_master_qualified_request_sdram_0_s1;
  --cpu_0/data_master grant sdram_0/s1, which is an e_assign
  internal_cpu_0_data_master_granted_sdram_0_s1 <= sdram_0_s1_grant_vector(1);
  --cpu_0/data_master saved-grant sdram_0/s1, which is an e_assign
  cpu_0_data_master_saved_grant_sdram_0_s1 <= sdram_0_s1_arb_winner(1) AND internal_cpu_0_data_master_requests_sdram_0_s1;
  --sdram_0/s1 chosen-master double-vector, which is an e_assign
  sdram_0_s1_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((sdram_0_s1_master_qreq_vector & sdram_0_s1_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT sdram_0_s1_master_qreq_vector & NOT sdram_0_s1_master_qreq_vector))) + (std_logic_vector'("000") & (sdram_0_s1_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  sdram_0_s1_arb_winner <= A_WE_StdLogicVector((std_logic'(((sdram_0_s1_allow_new_arb_cycle AND or_reduce(sdram_0_s1_grant_vector)))) = '1'), sdram_0_s1_grant_vector, sdram_0_s1_saved_chosen_master_vector);
  --saved sdram_0_s1_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_0_s1_allow_new_arb_cycle) = '1' then 
        sdram_0_s1_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(sdram_0_s1_grant_vector)) = '1'), sdram_0_s1_grant_vector, sdram_0_s1_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  sdram_0_s1_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((sdram_0_s1_chosen_master_double_vector(1) OR sdram_0_s1_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((sdram_0_s1_chosen_master_double_vector(0) OR sdram_0_s1_chosen_master_double_vector(2)))));
  --sdram_0/s1 chosen master rotated left, which is an e_assign
  sdram_0_s1_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(sdram_0_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(sdram_0_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --sdram_0/s1's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(sdram_0_s1_grant_vector)) = '1' then 
        sdram_0_s1_arb_addend <= A_WE_StdLogicVector((std_logic'(sdram_0_s1_end_xfer) = '1'), sdram_0_s1_chosen_master_rot_left, sdram_0_s1_grant_vector);
      end if;
    end if;

  end process;

  --sdram_0_s1_reset_n assignment, which is an e_assign
  sdram_0_s1_reset_n <= reset_n;
  sdram_0_s1_chipselect <= internal_cpu_0_data_master_granted_sdram_0_s1 OR internal_cpu_0_instruction_master_granted_sdram_0_s1;
  --sdram_0_s1_firsttransfer first transaction, which is an e_assign
  sdram_0_s1_firsttransfer <= A_WE_StdLogic((std_logic'(sdram_0_s1_begins_xfer) = '1'), sdram_0_s1_unreg_firsttransfer, sdram_0_s1_reg_firsttransfer);
  --sdram_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  sdram_0_s1_unreg_firsttransfer <= NOT ((sdram_0_s1_slavearbiterlockenable AND sdram_0_s1_any_continuerequest));
  --sdram_0_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_0_s1_begins_xfer) = '1' then 
        sdram_0_s1_reg_firsttransfer <= sdram_0_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sdram_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sdram_0_s1_beginbursttransfer_internal <= sdram_0_s1_begins_xfer;
  --sdram_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  sdram_0_s1_arbitration_holdoff_internal <= sdram_0_s1_begins_xfer AND sdram_0_s1_firsttransfer;
  --~sdram_0_s1_read_n assignment, which is an e_mux
  sdram_0_s1_read_n <= NOT ((((internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_sdram_0_s1 AND cpu_0_instruction_master_read))));
  --~sdram_0_s1_write_n assignment, which is an e_mux
  sdram_0_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_write));
  shifted_address_to_sdram_0_s1_from_cpu_0_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_0_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_0_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 27);
  --sdram_0_s1_address mux, which is an e_mux
  sdram_0_s1_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), (A_SRL(shifted_address_to_sdram_0_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000001"))), (A_SRL(shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master,std_logic_vector'("00000000000000000000000000000001")))), 24);
  shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_0_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_0_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 27);
  --d1_sdram_0_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sdram_0_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sdram_0_s1_end_xfer <= sdram_0_s1_end_xfer;
    end if;

  end process;

  --sdram_0_s1_waits_for_read in a cycle, which is an e_mux
  sdram_0_s1_waits_for_read <= sdram_0_s1_in_a_read_cycle AND internal_sdram_0_s1_waitrequest_from_sa;
  --sdram_0_s1_in_a_read_cycle assignment, which is an e_assign
  sdram_0_s1_in_a_read_cycle <= ((internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_sdram_0_s1 AND cpu_0_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sdram_0_s1_in_a_read_cycle;
  --sdram_0_s1_waits_for_write in a cycle, which is an e_mux
  sdram_0_s1_waits_for_write <= sdram_0_s1_in_a_write_cycle AND internal_sdram_0_s1_waitrequest_from_sa;
  --sdram_0_s1_in_a_write_cycle assignment, which is an e_assign
  sdram_0_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sdram_0_s1_in_a_write_cycle;
  wait_for_sdram_0_s1_counter <= std_logic'('0');
  --~sdram_0_s1_byteenable_n byte enable port mux, which is an e_mux
  sdram_0_s1_byteenable_n <= A_EXT (NOT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_cpu_0_data_master_byteenable_sdram_0_s1)), -SIGNED(std_logic_vector'("00000000000000000000000000000001")))), 2);
  (cpu_0_data_master_byteenable_sdram_0_s1_segment_1(1), cpu_0_data_master_byteenable_sdram_0_s1_segment_1(0), cpu_0_data_master_byteenable_sdram_0_s1_segment_0(1), cpu_0_data_master_byteenable_sdram_0_s1_segment_0(0)) <= cpu_0_data_master_byteenable;
  internal_cpu_0_data_master_byteenable_sdram_0_s1 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_0_data_master_byteenable_sdram_0_s1_segment_0, cpu_0_data_master_byteenable_sdram_0_s1_segment_1);
  --vhdl renameroo for output signals
  cpu_0_data_master_byteenable_sdram_0_s1 <= internal_cpu_0_data_master_byteenable_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_sdram_0_s1 <= internal_cpu_0_data_master_granted_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_sdram_0_s1 <= internal_cpu_0_data_master_qualified_request_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_sdram_0_s1 <= internal_cpu_0_data_master_requests_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_granted_sdram_0_s1 <= internal_cpu_0_instruction_master_granted_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_qualified_request_sdram_0_s1 <= internal_cpu_0_instruction_master_qualified_request_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_requests_sdram_0_s1 <= internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --vhdl renameroo for output signals
  sdram_0_s1_waitrequest_from_sa <= internal_sdram_0_s1_waitrequest_from_sa;
--synthesis translate_off
    --sdram_0/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line11 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_granted_sdram_0_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_instruction_master_granted_sdram_0_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line11, now);
          write(write_line11, string'(": "));
          write(write_line11, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line11.all);
          deallocate (write_line11);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line12 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_saved_grant_sdram_0_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_saved_grant_sdram_0_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line12, now);
          write(write_line12, string'(": "));
          write(write_line12, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line12.all);
          deallocate (write_line12);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sysid_0_control_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sysid_0_control_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_granted_sysid_0_control_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_sysid_0_control_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sysid_0_control_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_sysid_0_control_slave : OUT STD_LOGIC;
                 signal d1_sysid_0_control_slave_end_xfer : OUT STD_LOGIC;
                 signal sysid_0_control_slave_address : OUT STD_LOGIC;
                 signal sysid_0_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal sysid_0_control_slave_reset_n : OUT STD_LOGIC
              );
end entity sysid_0_control_slave_arbitrator;


architecture europa of sysid_0_control_slave_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_sysid_0_control_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sysid_0_control_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_sysid_0_control_slave :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_sysid_0_control_slave :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_sysid_0_control_slave :  STD_LOGIC;
                signal shifted_address_to_sysid_0_control_slave_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal sysid_0_control_slave_allgrants :  STD_LOGIC;
                signal sysid_0_control_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal sysid_0_control_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sysid_0_control_slave_any_continuerequest :  STD_LOGIC;
                signal sysid_0_control_slave_arb_counter_enable :  STD_LOGIC;
                signal sysid_0_control_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sysid_0_control_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sysid_0_control_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sysid_0_control_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal sysid_0_control_slave_begins_xfer :  STD_LOGIC;
                signal sysid_0_control_slave_end_xfer :  STD_LOGIC;
                signal sysid_0_control_slave_firsttransfer :  STD_LOGIC;
                signal sysid_0_control_slave_grant_vector :  STD_LOGIC;
                signal sysid_0_control_slave_in_a_read_cycle :  STD_LOGIC;
                signal sysid_0_control_slave_in_a_write_cycle :  STD_LOGIC;
                signal sysid_0_control_slave_master_qreq_vector :  STD_LOGIC;
                signal sysid_0_control_slave_non_bursting_master_requests :  STD_LOGIC;
                signal sysid_0_control_slave_reg_firsttransfer :  STD_LOGIC;
                signal sysid_0_control_slave_slavearbiterlockenable :  STD_LOGIC;
                signal sysid_0_control_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal sysid_0_control_slave_unreg_firsttransfer :  STD_LOGIC;
                signal sysid_0_control_slave_waits_for_read :  STD_LOGIC;
                signal sysid_0_control_slave_waits_for_write :  STD_LOGIC;
                signal wait_for_sysid_0_control_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sysid_0_control_slave_end_xfer;
    end if;

  end process;

  sysid_0_control_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_sysid_0_control_slave);
  --assign sysid_0_control_slave_readdata_from_sa = sysid_0_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sysid_0_control_slave_readdata_from_sa <= sysid_0_control_slave_readdata;
  internal_cpu_0_data_master_requests_sysid_0_control_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100000010000010000011111000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write)))) AND cpu_0_data_master_read;
  --sysid_0_control_slave_arb_share_counter set values, which is an e_mux
  sysid_0_control_slave_arb_share_set_values <= std_logic_vector'("001");
  --sysid_0_control_slave_non_bursting_master_requests mux, which is an e_mux
  sysid_0_control_slave_non_bursting_master_requests <= internal_cpu_0_data_master_requests_sysid_0_control_slave;
  --sysid_0_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  sysid_0_control_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --sysid_0_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  sysid_0_control_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sysid_0_control_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sysid_0_control_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sysid_0_control_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sysid_0_control_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --sysid_0_control_slave_allgrants all slave grants, which is an e_mux
  sysid_0_control_slave_allgrants <= sysid_0_control_slave_grant_vector;
  --sysid_0_control_slave_end_xfer assignment, which is an e_assign
  sysid_0_control_slave_end_xfer <= NOT ((sysid_0_control_slave_waits_for_read OR sysid_0_control_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_sysid_0_control_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sysid_0_control_slave <= sysid_0_control_slave_end_xfer AND (((NOT sysid_0_control_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sysid_0_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  sysid_0_control_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sysid_0_control_slave AND sysid_0_control_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_sysid_0_control_slave AND NOT sysid_0_control_slave_non_bursting_master_requests));
  --sysid_0_control_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_0_control_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(sysid_0_control_slave_arb_counter_enable) = '1' then 
        sysid_0_control_slave_arb_share_counter <= sysid_0_control_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sysid_0_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_0_control_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((sysid_0_control_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_sysid_0_control_slave)) OR ((end_xfer_arb_share_counter_term_sysid_0_control_slave AND NOT sysid_0_control_slave_non_bursting_master_requests)))) = '1' then 
        sysid_0_control_slave_slavearbiterlockenable <= or_reduce(sysid_0_control_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master sysid_0/control_slave arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= sysid_0_control_slave_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --sysid_0_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sysid_0_control_slave_slavearbiterlockenable2 <= or_reduce(sysid_0_control_slave_arb_share_counter_next_value);
  --cpu_0/data_master sysid_0/control_slave arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= sysid_0_control_slave_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --sysid_0_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  sysid_0_control_slave_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_sysid_0_control_slave <= internal_cpu_0_data_master_requests_sysid_0_control_slave AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_sysid_0_control_slave, which is an e_mux
  cpu_0_data_master_read_data_valid_sysid_0_control_slave <= (internal_cpu_0_data_master_granted_sysid_0_control_slave AND cpu_0_data_master_read) AND NOT sysid_0_control_slave_waits_for_read;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_sysid_0_control_slave <= internal_cpu_0_data_master_qualified_request_sysid_0_control_slave;
  --cpu_0/data_master saved-grant sysid_0/control_slave, which is an e_assign
  cpu_0_data_master_saved_grant_sysid_0_control_slave <= internal_cpu_0_data_master_requests_sysid_0_control_slave;
  --allow new arb cycle for sysid_0/control_slave, which is an e_assign
  sysid_0_control_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  sysid_0_control_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  sysid_0_control_slave_master_qreq_vector <= std_logic'('1');
  --sysid_0_control_slave_reset_n assignment, which is an e_assign
  sysid_0_control_slave_reset_n <= reset_n;
  --sysid_0_control_slave_firsttransfer first transaction, which is an e_assign
  sysid_0_control_slave_firsttransfer <= A_WE_StdLogic((std_logic'(sysid_0_control_slave_begins_xfer) = '1'), sysid_0_control_slave_unreg_firsttransfer, sysid_0_control_slave_reg_firsttransfer);
  --sysid_0_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  sysid_0_control_slave_unreg_firsttransfer <= NOT ((sysid_0_control_slave_slavearbiterlockenable AND sysid_0_control_slave_any_continuerequest));
  --sysid_0_control_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_0_control_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sysid_0_control_slave_begins_xfer) = '1' then 
        sysid_0_control_slave_reg_firsttransfer <= sysid_0_control_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sysid_0_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sysid_0_control_slave_beginbursttransfer_internal <= sysid_0_control_slave_begins_xfer;
  shifted_address_to_sysid_0_control_slave_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --sysid_0_control_slave_address mux, which is an e_mux
  sysid_0_control_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_sysid_0_control_slave_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_sysid_0_control_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sysid_0_control_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sysid_0_control_slave_end_xfer <= sysid_0_control_slave_end_xfer;
    end if;

  end process;

  --sysid_0_control_slave_waits_for_read in a cycle, which is an e_mux
  sysid_0_control_slave_waits_for_read <= sysid_0_control_slave_in_a_read_cycle AND sysid_0_control_slave_begins_xfer;
  --sysid_0_control_slave_in_a_read_cycle assignment, which is an e_assign
  sysid_0_control_slave_in_a_read_cycle <= internal_cpu_0_data_master_granted_sysid_0_control_slave AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sysid_0_control_slave_in_a_read_cycle;
  --sysid_0_control_slave_waits_for_write in a cycle, which is an e_mux
  sysid_0_control_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sysid_0_control_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --sysid_0_control_slave_in_a_write_cycle assignment, which is an e_assign
  sysid_0_control_slave_in_a_write_cycle <= internal_cpu_0_data_master_granted_sysid_0_control_slave AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sysid_0_control_slave_in_a_write_cycle;
  wait_for_sysid_0_control_slave_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_sysid_0_control_slave <= internal_cpu_0_data_master_granted_sysid_0_control_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_sysid_0_control_slave <= internal_cpu_0_data_master_qualified_request_sysid_0_control_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_sysid_0_control_slave <= internal_cpu_0_data_master_requests_sysid_0_control_slave;
--synthesis translate_off
    --sysid_0/control_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity timer_0_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal timer_0_s1_irq : IN STD_LOGIC;
                 signal timer_0_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_granted_timer_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_timer_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_timer_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_timer_0_s1 : OUT STD_LOGIC;
                 signal d1_timer_0_s1_end_xfer : OUT STD_LOGIC;
                 signal timer_0_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal timer_0_s1_chipselect : OUT STD_LOGIC;
                 signal timer_0_s1_irq_from_sa : OUT STD_LOGIC;
                 signal timer_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal timer_0_s1_reset_n : OUT STD_LOGIC;
                 signal timer_0_s1_write_n : OUT STD_LOGIC;
                 signal timer_0_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity timer_0_s1_arbitrator;


architecture europa of timer_0_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_timer_0_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_timer_0_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_timer_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_timer_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_timer_0_s1 :  STD_LOGIC;
                signal shifted_address_to_timer_0_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal timer_0_s1_allgrants :  STD_LOGIC;
                signal timer_0_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal timer_0_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal timer_0_s1_any_continuerequest :  STD_LOGIC;
                signal timer_0_s1_arb_counter_enable :  STD_LOGIC;
                signal timer_0_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_0_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_0_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_0_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal timer_0_s1_begins_xfer :  STD_LOGIC;
                signal timer_0_s1_end_xfer :  STD_LOGIC;
                signal timer_0_s1_firsttransfer :  STD_LOGIC;
                signal timer_0_s1_grant_vector :  STD_LOGIC;
                signal timer_0_s1_in_a_read_cycle :  STD_LOGIC;
                signal timer_0_s1_in_a_write_cycle :  STD_LOGIC;
                signal timer_0_s1_master_qreq_vector :  STD_LOGIC;
                signal timer_0_s1_non_bursting_master_requests :  STD_LOGIC;
                signal timer_0_s1_reg_firsttransfer :  STD_LOGIC;
                signal timer_0_s1_slavearbiterlockenable :  STD_LOGIC;
                signal timer_0_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal timer_0_s1_unreg_firsttransfer :  STD_LOGIC;
                signal timer_0_s1_waits_for_read :  STD_LOGIC;
                signal timer_0_s1_waits_for_write :  STD_LOGIC;
                signal wait_for_timer_0_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT timer_0_s1_end_xfer;
    end if;

  end process;

  timer_0_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_timer_0_s1);
  --assign timer_0_s1_readdata_from_sa = timer_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  timer_0_s1_readdata_from_sa <= timer_0_s1_readdata;
  internal_cpu_0_data_master_requests_timer_0_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000010000010000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --timer_0_s1_arb_share_counter set values, which is an e_mux
  timer_0_s1_arb_share_set_values <= std_logic_vector'("001");
  --timer_0_s1_non_bursting_master_requests mux, which is an e_mux
  timer_0_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_timer_0_s1;
  --timer_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  timer_0_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --timer_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  timer_0_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(timer_0_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (timer_0_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(timer_0_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (timer_0_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --timer_0_s1_allgrants all slave grants, which is an e_mux
  timer_0_s1_allgrants <= timer_0_s1_grant_vector;
  --timer_0_s1_end_xfer assignment, which is an e_assign
  timer_0_s1_end_xfer <= NOT ((timer_0_s1_waits_for_read OR timer_0_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_timer_0_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_timer_0_s1 <= timer_0_s1_end_xfer AND (((NOT timer_0_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --timer_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  timer_0_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_timer_0_s1 AND timer_0_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_timer_0_s1 AND NOT timer_0_s1_non_bursting_master_requests));
  --timer_0_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_0_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(timer_0_s1_arb_counter_enable) = '1' then 
        timer_0_s1_arb_share_counter <= timer_0_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --timer_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_0_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((timer_0_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_timer_0_s1)) OR ((end_xfer_arb_share_counter_term_timer_0_s1 AND NOT timer_0_s1_non_bursting_master_requests)))) = '1' then 
        timer_0_s1_slavearbiterlockenable <= or_reduce(timer_0_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master timer_0/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= timer_0_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --timer_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  timer_0_s1_slavearbiterlockenable2 <= or_reduce(timer_0_s1_arb_share_counter_next_value);
  --cpu_0/data_master timer_0/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= timer_0_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --timer_0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  timer_0_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_timer_0_s1 <= internal_cpu_0_data_master_requests_timer_0_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_timer_0_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_timer_0_s1 <= (internal_cpu_0_data_master_granted_timer_0_s1 AND cpu_0_data_master_read) AND NOT timer_0_s1_waits_for_read;
  --timer_0_s1_writedata mux, which is an e_mux
  timer_0_s1_writedata <= cpu_0_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_0_data_master_granted_timer_0_s1 <= internal_cpu_0_data_master_qualified_request_timer_0_s1;
  --cpu_0/data_master saved-grant timer_0/s1, which is an e_assign
  cpu_0_data_master_saved_grant_timer_0_s1 <= internal_cpu_0_data_master_requests_timer_0_s1;
  --allow new arb cycle for timer_0/s1, which is an e_assign
  timer_0_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  timer_0_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  timer_0_s1_master_qreq_vector <= std_logic'('1');
  --timer_0_s1_reset_n assignment, which is an e_assign
  timer_0_s1_reset_n <= reset_n;
  timer_0_s1_chipselect <= internal_cpu_0_data_master_granted_timer_0_s1;
  --timer_0_s1_firsttransfer first transaction, which is an e_assign
  timer_0_s1_firsttransfer <= A_WE_StdLogic((std_logic'(timer_0_s1_begins_xfer) = '1'), timer_0_s1_unreg_firsttransfer, timer_0_s1_reg_firsttransfer);
  --timer_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  timer_0_s1_unreg_firsttransfer <= NOT ((timer_0_s1_slavearbiterlockenable AND timer_0_s1_any_continuerequest));
  --timer_0_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_0_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(timer_0_s1_begins_xfer) = '1' then 
        timer_0_s1_reg_firsttransfer <= timer_0_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --timer_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  timer_0_s1_beginbursttransfer_internal <= timer_0_s1_begins_xfer;
  --~timer_0_s1_write_n assignment, which is an e_mux
  timer_0_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_timer_0_s1 AND cpu_0_data_master_write));
  shifted_address_to_timer_0_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --timer_0_s1_address mux, which is an e_mux
  timer_0_s1_address <= A_EXT (A_SRL(shifted_address_to_timer_0_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_timer_0_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_timer_0_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_timer_0_s1_end_xfer <= timer_0_s1_end_xfer;
    end if;

  end process;

  --timer_0_s1_waits_for_read in a cycle, which is an e_mux
  timer_0_s1_waits_for_read <= timer_0_s1_in_a_read_cycle AND timer_0_s1_begins_xfer;
  --timer_0_s1_in_a_read_cycle assignment, which is an e_assign
  timer_0_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_timer_0_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= timer_0_s1_in_a_read_cycle;
  --timer_0_s1_waits_for_write in a cycle, which is an e_mux
  timer_0_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(timer_0_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --timer_0_s1_in_a_write_cycle assignment, which is an e_assign
  timer_0_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_timer_0_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= timer_0_s1_in_a_write_cycle;
  wait_for_timer_0_s1_counter <= std_logic'('0');
  --assign timer_0_s1_irq_from_sa = timer_0_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  timer_0_s1_irq_from_sa <= timer_0_s1_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_timer_0_s1 <= internal_cpu_0_data_master_granted_timer_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_timer_0_s1 <= internal_cpu_0_data_master_qualified_request_timer_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_timer_0_s1 <= internal_cpu_0_data_master_requests_timer_0_s1;
--synthesis translate_off
    --timer_0/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity tri_state_bridge_0_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_dbs_write_8 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal address_to_the_cfi_flash_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal cfi_flash_0_s1_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_byteenable_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_granted_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_granted_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_requests_cfi_flash_0_s1 : OUT STD_LOGIC;
                 signal d1_tri_state_bridge_0_avalon_slave_end_xfer : OUT STD_LOGIC;
                 signal data_to_and_from_the_cfi_flash_0 : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal incoming_data_to_and_from_the_cfi_flash_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal read_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                 signal select_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                 signal write_n_to_the_cfi_flash_0 : OUT STD_LOGIC
              );
end entity tri_state_bridge_0_avalon_slave_arbitrator;


architecture europa of tri_state_bridge_0_avalon_slave_arbitrator is
                signal cfi_flash_0_s1_counter_load_value :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cfi_flash_0_s1_in_a_read_cycle :  STD_LOGIC;
                signal cfi_flash_0_s1_in_a_write_cycle :  STD_LOGIC;
                signal cfi_flash_0_s1_pretend_byte_enable :  STD_LOGIC;
                signal cfi_flash_0_s1_wait_counter :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cfi_flash_0_s1_waits_for_read :  STD_LOGIC;
                signal cfi_flash_0_s1_waits_for_write :  STD_LOGIC;
                signal cfi_flash_0_s1_with_write_latency :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_0 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_1 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_2 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_3 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register_in :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register_in :  STD_LOGIC;
                signal cpu_0_instruction_master_saved_grant_cfi_flash_0_s1 :  STD_LOGIC;
                signal d1_in_a_write_cycle :  STD_LOGIC;
                signal d1_outgoing_data_to_and_from_the_cfi_flash_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_0_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_1_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_2_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_3_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_4_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_5_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_6_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_cfi_flash_0_bit_7_is_x :  STD_LOGIC;
                signal internal_cfi_flash_0_s1_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_byteenable_cfi_flash_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_cfi_flash_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_cfi_flash_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_cfi_flash_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_granted_cfi_flash_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_requests_cfi_flash_0_s1 :  STD_LOGIC;
                signal internal_incoming_data_to_and_from_the_cfi_flash_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal last_cycle_cpu_0_data_master_granted_slave_cfi_flash_0_s1 :  STD_LOGIC;
                signal last_cycle_cpu_0_instruction_master_granted_slave_cfi_flash_0_s1 :  STD_LOGIC;
                signal outgoing_data_to_and_from_the_cfi_flash_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_address_to_the_cfi_flash_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal p1_cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_read_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal p1_select_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal p1_write_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal time_to_write :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_allgrants :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_begins_xfer :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_end_xfer :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_firsttransfer :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_read_pending :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal tri_state_bridge_0_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal tri_state_bridge_0_avalon_slave_write_pending :  STD_LOGIC;
                signal wait_for_cfi_flash_0_s1_counter :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of address_to_the_cfi_flash_0 : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of d1_in_a_write_cycle : signal is "FAST_OUTPUT_ENABLE_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of d1_outgoing_data_to_and_from_the_cfi_flash_0 : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of internal_incoming_data_to_and_from_the_cfi_flash_0 : signal is "FAST_INPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of read_n_to_the_cfi_flash_0 : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of select_n_to_the_cfi_flash_0 : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of write_n_to_the_cfi_flash_0 : signal is "FAST_OUTPUT_REGISTER=ON";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT tri_state_bridge_0_avalon_slave_end_xfer;
    end if;

  end process;

  tri_state_bridge_0_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_0_data_master_qualified_request_cfi_flash_0_s1 OR internal_cpu_0_instruction_master_qualified_request_cfi_flash_0_s1));
  internal_cpu_0_data_master_requests_cfi_flash_0_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 18) & std_logic_vector'("000000000000000000")) = std_logic_vector'("100000001000000000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --~select_n_to_the_cfi_flash_0 of type chipselect to ~p1_select_n_to_the_cfi_flash_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      select_n_to_the_cfi_flash_0 <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      select_n_to_the_cfi_flash_0 <= p1_select_n_to_the_cfi_flash_0;
    end if;

  end process;

  tri_state_bridge_0_avalon_slave_write_pending <= std_logic'('0');
  --tri_state_bridge_0/avalon_slave read pending calc, which is an e_assign
  tri_state_bridge_0_avalon_slave_read_pending <= std_logic'('0');
  --tri_state_bridge_0_avalon_slave_arb_share_counter set values, which is an e_mux
  tri_state_bridge_0_avalon_slave_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cfi_flash_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_instruction_master_granted_cfi_flash_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cfi_flash_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_instruction_master_granted_cfi_flash_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), std_logic_vector'("00000000000000000000000000000001"))))), 3);
  --tri_state_bridge_0_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  tri_state_bridge_0_avalon_slave_non_bursting_master_requests <= ((internal_cpu_0_data_master_requests_cfi_flash_0_s1 OR internal_cpu_0_instruction_master_requests_cfi_flash_0_s1) OR internal_cpu_0_data_master_requests_cfi_flash_0_s1) OR internal_cpu_0_instruction_master_requests_cfi_flash_0_s1;
  --tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --tri_state_bridge_0_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  tri_state_bridge_0_avalon_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(tri_state_bridge_0_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (tri_state_bridge_0_avalon_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(tri_state_bridge_0_avalon_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (tri_state_bridge_0_avalon_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --tri_state_bridge_0_avalon_slave_allgrants all slave grants, which is an e_mux
  tri_state_bridge_0_avalon_slave_allgrants <= (((or_reduce(tri_state_bridge_0_avalon_slave_grant_vector)) OR (or_reduce(tri_state_bridge_0_avalon_slave_grant_vector))) OR (or_reduce(tri_state_bridge_0_avalon_slave_grant_vector))) OR (or_reduce(tri_state_bridge_0_avalon_slave_grant_vector));
  --tri_state_bridge_0_avalon_slave_end_xfer assignment, which is an e_assign
  tri_state_bridge_0_avalon_slave_end_xfer <= NOT ((cfi_flash_0_s1_waits_for_read OR cfi_flash_0_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave <= tri_state_bridge_0_avalon_slave_end_xfer AND (((NOT tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --tri_state_bridge_0_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  tri_state_bridge_0_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave AND tri_state_bridge_0_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave AND NOT tri_state_bridge_0_avalon_slave_non_bursting_master_requests));
  --tri_state_bridge_0_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      tri_state_bridge_0_avalon_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(tri_state_bridge_0_avalon_slave_arb_counter_enable) = '1' then 
        tri_state_bridge_0_avalon_slave_arb_share_counter <= tri_state_bridge_0_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --tri_state_bridge_0_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      tri_state_bridge_0_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(tri_state_bridge_0_avalon_slave_master_qreq_vector) AND end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave)) OR ((end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave AND NOT tri_state_bridge_0_avalon_slave_non_bursting_master_requests)))) = '1' then 
        tri_state_bridge_0_avalon_slave_slavearbiterlockenable <= or_reduce(tri_state_bridge_0_avalon_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master tri_state_bridge_0/avalon_slave arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= tri_state_bridge_0_avalon_slave_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 <= or_reduce(tri_state_bridge_0_avalon_slave_arb_share_counter_next_value);
  --cpu_0/data_master tri_state_bridge_0/avalon_slave arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --cpu_0/instruction_master tri_state_bridge_0/avalon_slave arbiterlock, which is an e_assign
  cpu_0_instruction_master_arbiterlock <= tri_state_bridge_0_avalon_slave_slavearbiterlockenable AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master tri_state_bridge_0/avalon_slave arbiterlock2, which is an e_assign
  cpu_0_instruction_master_arbiterlock2 <= tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master granted cfi_flash_0/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_instruction_master_granted_slave_cfi_flash_0_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_instruction_master_granted_slave_cfi_flash_0_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_instruction_master_saved_grant_cfi_flash_0_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal OR NOT internal_cpu_0_instruction_master_requests_cfi_flash_0_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_instruction_master_granted_slave_cfi_flash_0_s1))))));
    end if;

  end process;

  --cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  cpu_0_instruction_master_continuerequest <= last_cycle_cpu_0_instruction_master_granted_slave_cfi_flash_0_s1 AND internal_cpu_0_instruction_master_requests_cfi_flash_0_s1;
  --tri_state_bridge_0_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  tri_state_bridge_0_avalon_slave_any_continuerequest <= cpu_0_instruction_master_continuerequest OR cpu_0_data_master_continuerequest;
  internal_cpu_0_data_master_qualified_request_cfi_flash_0_s1 <= internal_cpu_0_data_master_requests_cfi_flash_0_s1 AND NOT (((((cpu_0_data_master_read AND ((((tri_state_bridge_0_avalon_slave_write_pending OR (tri_state_bridge_0_avalon_slave_read_pending)) OR to_std_logic(((std_logic_vector'("00000000000000000000000000000010")<(std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)))))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))))) OR ((((tri_state_bridge_0_avalon_slave_read_pending OR NOT(internal_cpu_0_data_master_byteenable_cfi_flash_0_s1))) AND cpu_0_data_master_write))) OR cpu_0_instruction_master_arbiterlock));
  --cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register_in <= (internal_cpu_0_data_master_granted_cfi_flash_0_s1 AND cpu_0_data_master_read) AND NOT cfi_flash_0_s1_waits_for_read;
  --shift register p1 cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register <= A_EXT ((cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register & A_ToStdLogicVector(cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register_in)), 2);
  --cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register <= p1_cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_0_data_master_read_data_valid_cfi_flash_0_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_cfi_flash_0_s1 <= cpu_0_data_master_read_data_valid_cfi_flash_0_s1_shift_register(1);
  --data_to_and_from_the_cfi_flash_0 register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_incoming_data_to_and_from_the_cfi_flash_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      internal_incoming_data_to_and_from_the_cfi_flash_0 <= data_to_and_from_the_cfi_flash_0;
    end if;

  end process;

  --cfi_flash_0_s1_with_write_latency assignment, which is an e_assign
  cfi_flash_0_s1_with_write_latency <= in_a_write_cycle AND ((internal_cpu_0_data_master_qualified_request_cfi_flash_0_s1 OR internal_cpu_0_instruction_master_qualified_request_cfi_flash_0_s1));
  --time to write the data, which is an e_mux
  time_to_write <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((cfi_flash_0_s1_with_write_latency)) = '1'), std_logic_vector'("00000000000000000000000000000001"), std_logic_vector'("00000000000000000000000000000000")));
  --d1_outgoing_data_to_and_from_the_cfi_flash_0 register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_outgoing_data_to_and_from_the_cfi_flash_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      d1_outgoing_data_to_and_from_the_cfi_flash_0 <= outgoing_data_to_and_from_the_cfi_flash_0;
    end if;

  end process;

  --write cycle delayed by 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_in_a_write_cycle <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_in_a_write_cycle <= time_to_write;
    end if;

  end process;

  --d1_outgoing_data_to_and_from_the_cfi_flash_0 tristate driver, which is an e_assign
  data_to_and_from_the_cfi_flash_0 <= A_WE_StdLogicVector((std_logic'((d1_in_a_write_cycle)) = '1'), d1_outgoing_data_to_and_from_the_cfi_flash_0, A_REP(std_logic'('Z'), 8));
  --outgoing_data_to_and_from_the_cfi_flash_0 mux, which is an e_mux
  outgoing_data_to_and_from_the_cfi_flash_0 <= cpu_0_data_master_dbs_write_8;
  internal_cpu_0_instruction_master_requests_cfi_flash_0_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_instruction_master_address_to_slave(26 DOWNTO 18) & std_logic_vector'("000000000000000000")) = std_logic_vector'("100000001000000000000000000")))) AND (cpu_0_instruction_master_read))) AND cpu_0_instruction_master_read;
  --cpu_0/data_master granted cfi_flash_0/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_data_master_granted_slave_cfi_flash_0_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_data_master_granted_slave_cfi_flash_0_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_data_master_saved_grant_cfi_flash_0_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal OR NOT internal_cpu_0_data_master_requests_cfi_flash_0_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_data_master_granted_slave_cfi_flash_0_s1))))));
    end if;

  end process;

  --cpu_0_data_master_continuerequest continued request, which is an e_mux
  cpu_0_data_master_continuerequest <= last_cycle_cpu_0_data_master_granted_slave_cfi_flash_0_s1 AND internal_cpu_0_data_master_requests_cfi_flash_0_s1;
  internal_cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 <= internal_cpu_0_instruction_master_requests_cfi_flash_0_s1 AND NOT ((((cpu_0_instruction_master_read AND ((((tri_state_bridge_0_avalon_slave_write_pending OR (tri_state_bridge_0_avalon_slave_read_pending)) OR to_std_logic(((std_logic_vector'("00000000000000000000000000000010")<(std_logic_vector'("000000000000000000000000000000") & (cpu_0_instruction_master_latency_counter)))))) OR (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))))) OR cpu_0_data_master_arbiterlock));
  --cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register_in <= (internal_cpu_0_instruction_master_granted_cfi_flash_0_s1 AND cpu_0_instruction_master_read) AND NOT cfi_flash_0_s1_waits_for_read;
  --shift register p1 cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register <= A_EXT ((cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register & A_ToStdLogicVector(cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register_in)), 2);
  --cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register <= p1_cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1, which is an e_mux
  cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 <= cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1_shift_register(1);
  --allow new arb cycle for tri_state_bridge_0/avalon_slave, which is an e_assign
  tri_state_bridge_0_avalon_slave_allow_new_arb_cycle <= NOT cpu_0_data_master_arbiterlock AND NOT cpu_0_instruction_master_arbiterlock;
  --cpu_0/instruction_master assignment into master qualified-requests vector for cfi_flash_0/s1, which is an e_assign
  tri_state_bridge_0_avalon_slave_master_qreq_vector(0) <= internal_cpu_0_instruction_master_qualified_request_cfi_flash_0_s1;
  --cpu_0/instruction_master grant cfi_flash_0/s1, which is an e_assign
  internal_cpu_0_instruction_master_granted_cfi_flash_0_s1 <= tri_state_bridge_0_avalon_slave_grant_vector(0);
  --cpu_0/instruction_master saved-grant cfi_flash_0/s1, which is an e_assign
  cpu_0_instruction_master_saved_grant_cfi_flash_0_s1 <= tri_state_bridge_0_avalon_slave_arb_winner(0) AND internal_cpu_0_instruction_master_requests_cfi_flash_0_s1;
  --cpu_0/data_master assignment into master qualified-requests vector for cfi_flash_0/s1, which is an e_assign
  tri_state_bridge_0_avalon_slave_master_qreq_vector(1) <= internal_cpu_0_data_master_qualified_request_cfi_flash_0_s1;
  --cpu_0/data_master grant cfi_flash_0/s1, which is an e_assign
  internal_cpu_0_data_master_granted_cfi_flash_0_s1 <= tri_state_bridge_0_avalon_slave_grant_vector(1);
  --cpu_0/data_master saved-grant cfi_flash_0/s1, which is an e_assign
  cpu_0_data_master_saved_grant_cfi_flash_0_s1 <= tri_state_bridge_0_avalon_slave_arb_winner(1) AND internal_cpu_0_data_master_requests_cfi_flash_0_s1;
  --tri_state_bridge_0/avalon_slave chosen-master double-vector, which is an e_assign
  tri_state_bridge_0_avalon_slave_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((tri_state_bridge_0_avalon_slave_master_qreq_vector & tri_state_bridge_0_avalon_slave_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT tri_state_bridge_0_avalon_slave_master_qreq_vector & NOT tri_state_bridge_0_avalon_slave_master_qreq_vector))) + (std_logic_vector'("000") & (tri_state_bridge_0_avalon_slave_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  tri_state_bridge_0_avalon_slave_arb_winner <= A_WE_StdLogicVector((std_logic'(((tri_state_bridge_0_avalon_slave_allow_new_arb_cycle AND or_reduce(tri_state_bridge_0_avalon_slave_grant_vector)))) = '1'), tri_state_bridge_0_avalon_slave_grant_vector, tri_state_bridge_0_avalon_slave_saved_chosen_master_vector);
  --saved tri_state_bridge_0_avalon_slave_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      tri_state_bridge_0_avalon_slave_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(tri_state_bridge_0_avalon_slave_allow_new_arb_cycle) = '1' then 
        tri_state_bridge_0_avalon_slave_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(tri_state_bridge_0_avalon_slave_grant_vector)) = '1'), tri_state_bridge_0_avalon_slave_grant_vector, tri_state_bridge_0_avalon_slave_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  tri_state_bridge_0_avalon_slave_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((tri_state_bridge_0_avalon_slave_chosen_master_double_vector(1) OR tri_state_bridge_0_avalon_slave_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((tri_state_bridge_0_avalon_slave_chosen_master_double_vector(0) OR tri_state_bridge_0_avalon_slave_chosen_master_double_vector(2)))));
  --tri_state_bridge_0/avalon_slave chosen master rotated left, which is an e_assign
  tri_state_bridge_0_avalon_slave_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(tri_state_bridge_0_avalon_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(tri_state_bridge_0_avalon_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --tri_state_bridge_0/avalon_slave's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      tri_state_bridge_0_avalon_slave_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(tri_state_bridge_0_avalon_slave_grant_vector)) = '1' then 
        tri_state_bridge_0_avalon_slave_arb_addend <= A_WE_StdLogicVector((std_logic'(tri_state_bridge_0_avalon_slave_end_xfer) = '1'), tri_state_bridge_0_avalon_slave_chosen_master_rot_left, tri_state_bridge_0_avalon_slave_grant_vector);
      end if;
    end if;

  end process;

  p1_select_n_to_the_cfi_flash_0 <= NOT ((internal_cpu_0_data_master_granted_cfi_flash_0_s1 OR internal_cpu_0_instruction_master_granted_cfi_flash_0_s1));
  --tri_state_bridge_0_avalon_slave_firsttransfer first transaction, which is an e_assign
  tri_state_bridge_0_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(tri_state_bridge_0_avalon_slave_begins_xfer) = '1'), tri_state_bridge_0_avalon_slave_unreg_firsttransfer, tri_state_bridge_0_avalon_slave_reg_firsttransfer);
  --tri_state_bridge_0_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  tri_state_bridge_0_avalon_slave_unreg_firsttransfer <= NOT ((tri_state_bridge_0_avalon_slave_slavearbiterlockenable AND tri_state_bridge_0_avalon_slave_any_continuerequest));
  --tri_state_bridge_0_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      tri_state_bridge_0_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(tri_state_bridge_0_avalon_slave_begins_xfer) = '1' then 
        tri_state_bridge_0_avalon_slave_reg_firsttransfer <= tri_state_bridge_0_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --tri_state_bridge_0_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  tri_state_bridge_0_avalon_slave_beginbursttransfer_internal <= tri_state_bridge_0_avalon_slave_begins_xfer;
  --tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal <= tri_state_bridge_0_avalon_slave_begins_xfer AND tri_state_bridge_0_avalon_slave_firsttransfer;
  --~read_n_to_the_cfi_flash_0 of type read to ~p1_read_n_to_the_cfi_flash_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      read_n_to_the_cfi_flash_0 <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      read_n_to_the_cfi_flash_0 <= p1_read_n_to_the_cfi_flash_0;
    end if;

  end process;

  --~p1_read_n_to_the_cfi_flash_0 assignment, which is an e_mux
  p1_read_n_to_the_cfi_flash_0 <= NOT (((((((internal_cpu_0_data_master_granted_cfi_flash_0_s1 AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_cfi_flash_0_s1 AND cpu_0_instruction_master_read)))) AND NOT tri_state_bridge_0_avalon_slave_begins_xfer) AND to_std_logic((((std_logic_vector'("0000000000000000000000000000") & (cfi_flash_0_s1_wait_counter))<std_logic_vector'("00000000000000000000000000001000"))))));
  --~write_n_to_the_cfi_flash_0 of type write to ~p1_write_n_to_the_cfi_flash_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      write_n_to_the_cfi_flash_0 <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      write_n_to_the_cfi_flash_0 <= p1_write_n_to_the_cfi_flash_0;
    end if;

  end process;

  --~p1_write_n_to_the_cfi_flash_0 assignment, which is an e_mux
  p1_write_n_to_the_cfi_flash_0 <= NOT (((((((internal_cpu_0_data_master_granted_cfi_flash_0_s1 AND cpu_0_data_master_write)) AND NOT tri_state_bridge_0_avalon_slave_begins_xfer) AND to_std_logic((((std_logic_vector'("0000000000000000000000000000") & (cfi_flash_0_s1_wait_counter))>=std_logic_vector'("00000000000000000000000000000010"))))) AND to_std_logic((((std_logic_vector'("0000000000000000000000000000") & (cfi_flash_0_s1_wait_counter))<std_logic_vector'("00000000000000000000000000001010"))))) AND cfi_flash_0_s1_pretend_byte_enable));
  --address_to_the_cfi_flash_0 of type address to p1_address_to_the_cfi_flash_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      address_to_the_cfi_flash_0 <= std_logic_vector'("000000000000000000");
    elsif clk'event and clk = '1' then
      address_to_the_cfi_flash_0 <= p1_address_to_the_cfi_flash_0;
    end if;

  end process;

  --p1_address_to_the_cfi_flash_0 mux, which is an e_mux
  p1_address_to_the_cfi_flash_0 <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cfi_flash_0_s1)) = '1'), (Std_Logic_Vector'(A_SRL(cpu_0_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & cpu_0_data_master_dbs_address(1 DOWNTO 0))), (Std_Logic_Vector'(A_SRL(cpu_0_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & cpu_0_instruction_master_dbs_address(1 DOWNTO 0)))), 18);
  --d1_tri_state_bridge_0_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_tri_state_bridge_0_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_tri_state_bridge_0_avalon_slave_end_xfer <= tri_state_bridge_0_avalon_slave_end_xfer;
    end if;

  end process;

  --cfi_flash_0_s1_waits_for_read in a cycle, which is an e_mux
  cfi_flash_0_s1_waits_for_read <= cfi_flash_0_s1_in_a_read_cycle AND wait_for_cfi_flash_0_s1_counter;
  --cfi_flash_0_s1_in_a_read_cycle assignment, which is an e_assign
  cfi_flash_0_s1_in_a_read_cycle <= ((internal_cpu_0_data_master_granted_cfi_flash_0_s1 AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_cfi_flash_0_s1 AND cpu_0_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= cfi_flash_0_s1_in_a_read_cycle;
  --cfi_flash_0_s1_waits_for_write in a cycle, which is an e_mux
  cfi_flash_0_s1_waits_for_write <= cfi_flash_0_s1_in_a_write_cycle AND wait_for_cfi_flash_0_s1_counter;
  --cfi_flash_0_s1_in_a_write_cycle assignment, which is an e_assign
  cfi_flash_0_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_cfi_flash_0_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= cfi_flash_0_s1_in_a_write_cycle;
  internal_cfi_flash_0_s1_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000") & (cfi_flash_0_s1_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cfi_flash_0_s1_wait_counter <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      cfi_flash_0_s1_wait_counter <= cfi_flash_0_s1_counter_load_value;
    end if;

  end process;

  cfi_flash_0_s1_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((cfi_flash_0_s1_in_a_write_cycle AND tri_state_bridge_0_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000001010"), A_WE_StdLogicVector((std_logic'(((cfi_flash_0_s1_in_a_read_cycle AND tri_state_bridge_0_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000001000"), A_WE_StdLogicVector((std_logic'((NOT internal_cfi_flash_0_s1_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000") & (cfi_flash_0_s1_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000")))), 4);
  wait_for_cfi_flash_0_s1_counter <= tri_state_bridge_0_avalon_slave_begins_xfer OR NOT internal_cfi_flash_0_s1_wait_counter_eq_0;
  --cfi_flash_0_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  cfi_flash_0_s1_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cfi_flash_0_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_byteenable_cfi_flash_0_s1))), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  (cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_3, cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_2, cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_1, cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_0) <= cpu_0_data_master_byteenable;
  internal_cpu_0_data_master_byteenable_cfi_flash_0_s1 <= A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_0, A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000001"))), cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_1, A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000010"))), cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_2, cpu_0_data_master_byteenable_cfi_flash_0_s1_segment_3)));
  --vhdl renameroo for output signals
  cfi_flash_0_s1_wait_counter_eq_0 <= internal_cfi_flash_0_s1_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_byteenable_cfi_flash_0_s1 <= internal_cpu_0_data_master_byteenable_cfi_flash_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_cfi_flash_0_s1 <= internal_cpu_0_data_master_granted_cfi_flash_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_cfi_flash_0_s1 <= internal_cpu_0_data_master_qualified_request_cfi_flash_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_cfi_flash_0_s1 <= internal_cpu_0_data_master_requests_cfi_flash_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_granted_cfi_flash_0_s1 <= internal_cpu_0_instruction_master_granted_cfi_flash_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 <= internal_cpu_0_instruction_master_qualified_request_cfi_flash_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_requests_cfi_flash_0_s1 <= internal_cpu_0_instruction_master_requests_cfi_flash_0_s1;
  --vhdl renameroo for output signals
  incoming_data_to_and_from_the_cfi_flash_0 <= internal_incoming_data_to_and_from_the_cfi_flash_0;
--synthesis translate_off
    --incoming_data_to_and_from_the_cfi_flash_0_bit_0_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_0_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(0))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[0] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(0) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_0_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(0));
    --incoming_data_to_and_from_the_cfi_flash_0_bit_1_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_1_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(1))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[1] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(1) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_1_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(1));
    --incoming_data_to_and_from_the_cfi_flash_0_bit_2_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_2_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(2))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[2] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(2) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_2_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(2));
    --incoming_data_to_and_from_the_cfi_flash_0_bit_3_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_3_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(3))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[3] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(3) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_3_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(3));
    --incoming_data_to_and_from_the_cfi_flash_0_bit_4_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_4_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(4))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[4] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(4) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_4_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(4));
    --incoming_data_to_and_from_the_cfi_flash_0_bit_5_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_5_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(5))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[5] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(5) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_5_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(5));
    --incoming_data_to_and_from_the_cfi_flash_0_bit_6_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_6_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(6))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[6] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(6) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_6_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(6));
    --incoming_data_to_and_from_the_cfi_flash_0_bit_7_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_cfi_flash_0_bit_7_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_cfi_flash_0(7))), '1','0');
    --Crush incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0[7] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0(7) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_cfi_flash_0_bit_7_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_cfi_flash_0(7));
    --cfi_flash_0/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line13 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_granted_cfi_flash_0_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_instruction_master_granted_cfi_flash_0_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line13, now);
          write(write_line13, string'(": "));
          write(write_line13, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line13.all);
          deallocate (write_line13);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line14 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_saved_grant_cfi_flash_0_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_saved_grant_cfi_flash_0_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line14, now);
          write(write_line14, string'(": "));
          write(write_line14, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line14.all);
          deallocate (write_line14);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on
--synthesis read_comments_as_HDL on
--    
--    incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 <= internal_incoming_data_to_and_from_the_cfi_flash_0;
--synthesis read_comments_as_HDL off

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tri_state_bridge_0_bridge_arbitrator is 
end entity tri_state_bridge_0_bridge_arbitrator;


architecture europa of tri_state_bridge_0_bridge_arbitrator is

begin


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity wr_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal wr_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_granted_wr_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_wr_s1 : OUT STD_LOGIC;
                 signal d1_wr_s1_end_xfer : OUT STD_LOGIC;
                 signal wr_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal wr_s1_chipselect : OUT STD_LOGIC;
                 signal wr_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal wr_s1_reset_n : OUT STD_LOGIC;
                 signal wr_s1_write_n : OUT STD_LOGIC;
                 signal wr_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity wr_s1_arbitrator;


architecture europa of wr_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_wr_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_wr_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_wr_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_wr_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_wr_s1 :  STD_LOGIC;
                signal shifted_address_to_wr_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_wr_s1_counter :  STD_LOGIC;
                signal wr_s1_allgrants :  STD_LOGIC;
                signal wr_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal wr_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal wr_s1_any_continuerequest :  STD_LOGIC;
                signal wr_s1_arb_counter_enable :  STD_LOGIC;
                signal wr_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal wr_s1_begins_xfer :  STD_LOGIC;
                signal wr_s1_end_xfer :  STD_LOGIC;
                signal wr_s1_firsttransfer :  STD_LOGIC;
                signal wr_s1_grant_vector :  STD_LOGIC;
                signal wr_s1_in_a_read_cycle :  STD_LOGIC;
                signal wr_s1_in_a_write_cycle :  STD_LOGIC;
                signal wr_s1_master_qreq_vector :  STD_LOGIC;
                signal wr_s1_non_bursting_master_requests :  STD_LOGIC;
                signal wr_s1_reg_firsttransfer :  STD_LOGIC;
                signal wr_s1_slavearbiterlockenable :  STD_LOGIC;
                signal wr_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal wr_s1_unreg_firsttransfer :  STD_LOGIC;
                signal wr_s1_waits_for_read :  STD_LOGIC;
                signal wr_s1_waits_for_write :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT wr_s1_end_xfer;
    end if;

  end process;

  wr_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_wr_s1);
  --assign wr_s1_readdata_from_sa = wr_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  wr_s1_readdata_from_sa <= wr_s1_readdata;
  internal_cpu_0_data_master_requests_wr_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000001000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --wr_s1_arb_share_counter set values, which is an e_mux
  wr_s1_arb_share_set_values <= std_logic_vector'("001");
  --wr_s1_non_bursting_master_requests mux, which is an e_mux
  wr_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_wr_s1;
  --wr_s1_any_bursting_master_saved_grant mux, which is an e_mux
  wr_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --wr_s1_arb_share_counter_next_value assignment, which is an e_assign
  wr_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(wr_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(wr_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --wr_s1_allgrants all slave grants, which is an e_mux
  wr_s1_allgrants <= wr_s1_grant_vector;
  --wr_s1_end_xfer assignment, which is an e_assign
  wr_s1_end_xfer <= NOT ((wr_s1_waits_for_read OR wr_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_wr_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_wr_s1 <= wr_s1_end_xfer AND (((NOT wr_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --wr_s1_arb_share_counter arbitration counter enable, which is an e_assign
  wr_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_wr_s1 AND wr_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_wr_s1 AND NOT wr_s1_non_bursting_master_requests));
  --wr_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(wr_s1_arb_counter_enable) = '1' then 
        wr_s1_arb_share_counter <= wr_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --wr_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((wr_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_wr_s1)) OR ((end_xfer_arb_share_counter_term_wr_s1 AND NOT wr_s1_non_bursting_master_requests)))) = '1' then 
        wr_s1_slavearbiterlockenable <= or_reduce(wr_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master wr/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= wr_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --wr_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  wr_s1_slavearbiterlockenable2 <= or_reduce(wr_s1_arb_share_counter_next_value);
  --cpu_0/data_master wr/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= wr_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --wr_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  wr_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_wr_s1 <= internal_cpu_0_data_master_requests_wr_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_wr_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_wr_s1 <= (internal_cpu_0_data_master_granted_wr_s1 AND cpu_0_data_master_read) AND NOT wr_s1_waits_for_read;
  --wr_s1_writedata mux, which is an e_mux
  wr_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_wr_s1 <= internal_cpu_0_data_master_qualified_request_wr_s1;
  --cpu_0/data_master saved-grant wr/s1, which is an e_assign
  cpu_0_data_master_saved_grant_wr_s1 <= internal_cpu_0_data_master_requests_wr_s1;
  --allow new arb cycle for wr/s1, which is an e_assign
  wr_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  wr_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  wr_s1_master_qreq_vector <= std_logic'('1');
  --wr_s1_reset_n assignment, which is an e_assign
  wr_s1_reset_n <= reset_n;
  wr_s1_chipselect <= internal_cpu_0_data_master_granted_wr_s1;
  --wr_s1_firsttransfer first transaction, which is an e_assign
  wr_s1_firsttransfer <= A_WE_StdLogic((std_logic'(wr_s1_begins_xfer) = '1'), wr_s1_unreg_firsttransfer, wr_s1_reg_firsttransfer);
  --wr_s1_unreg_firsttransfer first transaction, which is an e_assign
  wr_s1_unreg_firsttransfer <= NOT ((wr_s1_slavearbiterlockenable AND wr_s1_any_continuerequest));
  --wr_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(wr_s1_begins_xfer) = '1' then 
        wr_s1_reg_firsttransfer <= wr_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --wr_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  wr_s1_beginbursttransfer_internal <= wr_s1_begins_xfer;
  --~wr_s1_write_n assignment, which is an e_mux
  wr_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_wr_s1 AND cpu_0_data_master_write));
  shifted_address_to_wr_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --wr_s1_address mux, which is an e_mux
  wr_s1_address <= A_EXT (A_SRL(shifted_address_to_wr_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_wr_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_wr_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_wr_s1_end_xfer <= wr_s1_end_xfer;
    end if;

  end process;

  --wr_s1_waits_for_read in a cycle, which is an e_mux
  wr_s1_waits_for_read <= wr_s1_in_a_read_cycle AND wr_s1_begins_xfer;
  --wr_s1_in_a_read_cycle assignment, which is an e_assign
  wr_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_wr_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= wr_s1_in_a_read_cycle;
  --wr_s1_waits_for_write in a cycle, which is an e_mux
  wr_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(wr_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --wr_s1_in_a_write_cycle assignment, which is an e_assign
  wr_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_wr_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= wr_s1_in_a_write_cycle;
  wait_for_wr_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_wr_s1 <= internal_cpu_0_data_master_granted_wr_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_wr_s1 <= internal_cpu_0_data_master_qualified_request_wr_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_wr_s1 <= internal_cpu_0_data_master_requests_wr_s1;
--synthesis translate_off
    --wr/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity wr2_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal wr2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_granted_wr2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr2_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_wr2_s1 : OUT STD_LOGIC;
                 signal d1_wr2_s1_end_xfer : OUT STD_LOGIC;
                 signal wr2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal wr2_s1_chipselect : OUT STD_LOGIC;
                 signal wr2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal wr2_s1_reset_n : OUT STD_LOGIC;
                 signal wr2_s1_write_n : OUT STD_LOGIC;
                 signal wr2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity wr2_s1_arbitrator;


architecture europa of wr2_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_wr2_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_wr2_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_wr2_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_wr2_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_wr2_s1 :  STD_LOGIC;
                signal shifted_address_to_wr2_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_wr2_s1_counter :  STD_LOGIC;
                signal wr2_s1_allgrants :  STD_LOGIC;
                signal wr2_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal wr2_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal wr2_s1_any_continuerequest :  STD_LOGIC;
                signal wr2_s1_arb_counter_enable :  STD_LOGIC;
                signal wr2_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr2_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr2_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr2_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal wr2_s1_begins_xfer :  STD_LOGIC;
                signal wr2_s1_end_xfer :  STD_LOGIC;
                signal wr2_s1_firsttransfer :  STD_LOGIC;
                signal wr2_s1_grant_vector :  STD_LOGIC;
                signal wr2_s1_in_a_read_cycle :  STD_LOGIC;
                signal wr2_s1_in_a_write_cycle :  STD_LOGIC;
                signal wr2_s1_master_qreq_vector :  STD_LOGIC;
                signal wr2_s1_non_bursting_master_requests :  STD_LOGIC;
                signal wr2_s1_reg_firsttransfer :  STD_LOGIC;
                signal wr2_s1_slavearbiterlockenable :  STD_LOGIC;
                signal wr2_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal wr2_s1_unreg_firsttransfer :  STD_LOGIC;
                signal wr2_s1_waits_for_read :  STD_LOGIC;
                signal wr2_s1_waits_for_write :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT wr2_s1_end_xfer;
    end if;

  end process;

  wr2_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_wr2_s1);
  --assign wr2_s1_readdata_from_sa = wr2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  wr2_s1_readdata_from_sa <= wr2_s1_readdata;
  internal_cpu_0_data_master_requests_wr2_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000011000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --wr2_s1_arb_share_counter set values, which is an e_mux
  wr2_s1_arb_share_set_values <= std_logic_vector'("001");
  --wr2_s1_non_bursting_master_requests mux, which is an e_mux
  wr2_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_wr2_s1;
  --wr2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  wr2_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --wr2_s1_arb_share_counter_next_value assignment, which is an e_assign
  wr2_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(wr2_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr2_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(wr2_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr2_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --wr2_s1_allgrants all slave grants, which is an e_mux
  wr2_s1_allgrants <= wr2_s1_grant_vector;
  --wr2_s1_end_xfer assignment, which is an e_assign
  wr2_s1_end_xfer <= NOT ((wr2_s1_waits_for_read OR wr2_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_wr2_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_wr2_s1 <= wr2_s1_end_xfer AND (((NOT wr2_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --wr2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  wr2_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_wr2_s1 AND wr2_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_wr2_s1 AND NOT wr2_s1_non_bursting_master_requests));
  --wr2_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr2_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(wr2_s1_arb_counter_enable) = '1' then 
        wr2_s1_arb_share_counter <= wr2_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --wr2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr2_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((wr2_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_wr2_s1)) OR ((end_xfer_arb_share_counter_term_wr2_s1 AND NOT wr2_s1_non_bursting_master_requests)))) = '1' then 
        wr2_s1_slavearbiterlockenable <= or_reduce(wr2_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master wr2/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= wr2_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --wr2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  wr2_s1_slavearbiterlockenable2 <= or_reduce(wr2_s1_arb_share_counter_next_value);
  --cpu_0/data_master wr2/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= wr2_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --wr2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  wr2_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_wr2_s1 <= internal_cpu_0_data_master_requests_wr2_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_wr2_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_wr2_s1 <= (internal_cpu_0_data_master_granted_wr2_s1 AND cpu_0_data_master_read) AND NOT wr2_s1_waits_for_read;
  --wr2_s1_writedata mux, which is an e_mux
  wr2_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_wr2_s1 <= internal_cpu_0_data_master_qualified_request_wr2_s1;
  --cpu_0/data_master saved-grant wr2/s1, which is an e_assign
  cpu_0_data_master_saved_grant_wr2_s1 <= internal_cpu_0_data_master_requests_wr2_s1;
  --allow new arb cycle for wr2/s1, which is an e_assign
  wr2_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  wr2_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  wr2_s1_master_qreq_vector <= std_logic'('1');
  --wr2_s1_reset_n assignment, which is an e_assign
  wr2_s1_reset_n <= reset_n;
  wr2_s1_chipselect <= internal_cpu_0_data_master_granted_wr2_s1;
  --wr2_s1_firsttransfer first transaction, which is an e_assign
  wr2_s1_firsttransfer <= A_WE_StdLogic((std_logic'(wr2_s1_begins_xfer) = '1'), wr2_s1_unreg_firsttransfer, wr2_s1_reg_firsttransfer);
  --wr2_s1_unreg_firsttransfer first transaction, which is an e_assign
  wr2_s1_unreg_firsttransfer <= NOT ((wr2_s1_slavearbiterlockenable AND wr2_s1_any_continuerequest));
  --wr2_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr2_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(wr2_s1_begins_xfer) = '1' then 
        wr2_s1_reg_firsttransfer <= wr2_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --wr2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  wr2_s1_beginbursttransfer_internal <= wr2_s1_begins_xfer;
  --~wr2_s1_write_n assignment, which is an e_mux
  wr2_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_wr2_s1 AND cpu_0_data_master_write));
  shifted_address_to_wr2_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --wr2_s1_address mux, which is an e_mux
  wr2_s1_address <= A_EXT (A_SRL(shifted_address_to_wr2_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_wr2_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_wr2_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_wr2_s1_end_xfer <= wr2_s1_end_xfer;
    end if;

  end process;

  --wr2_s1_waits_for_read in a cycle, which is an e_mux
  wr2_s1_waits_for_read <= wr2_s1_in_a_read_cycle AND wr2_s1_begins_xfer;
  --wr2_s1_in_a_read_cycle assignment, which is an e_assign
  wr2_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_wr2_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= wr2_s1_in_a_read_cycle;
  --wr2_s1_waits_for_write in a cycle, which is an e_mux
  wr2_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(wr2_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --wr2_s1_in_a_write_cycle assignment, which is an e_assign
  wr2_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_wr2_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= wr2_s1_in_a_write_cycle;
  wait_for_wr2_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_wr2_s1 <= internal_cpu_0_data_master_granted_wr2_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_wr2_s1 <= internal_cpu_0_data_master_qualified_request_wr2_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_wr2_s1 <= internal_cpu_0_data_master_requests_wr2_s1;
--synthesis translate_off
    --wr2/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity wr3_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal wr3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_granted_wr3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr3_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_wr3_s1 : OUT STD_LOGIC;
                 signal d1_wr3_s1_end_xfer : OUT STD_LOGIC;
                 signal wr3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal wr3_s1_chipselect : OUT STD_LOGIC;
                 signal wr3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal wr3_s1_reset_n : OUT STD_LOGIC;
                 signal wr3_s1_write_n : OUT STD_LOGIC;
                 signal wr3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity wr3_s1_arbitrator;


architecture europa of wr3_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_wr3_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_wr3_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_wr3_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_wr3_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_wr3_s1 :  STD_LOGIC;
                signal shifted_address_to_wr3_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_wr3_s1_counter :  STD_LOGIC;
                signal wr3_s1_allgrants :  STD_LOGIC;
                signal wr3_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal wr3_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal wr3_s1_any_continuerequest :  STD_LOGIC;
                signal wr3_s1_arb_counter_enable :  STD_LOGIC;
                signal wr3_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr3_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr3_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr3_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal wr3_s1_begins_xfer :  STD_LOGIC;
                signal wr3_s1_end_xfer :  STD_LOGIC;
                signal wr3_s1_firsttransfer :  STD_LOGIC;
                signal wr3_s1_grant_vector :  STD_LOGIC;
                signal wr3_s1_in_a_read_cycle :  STD_LOGIC;
                signal wr3_s1_in_a_write_cycle :  STD_LOGIC;
                signal wr3_s1_master_qreq_vector :  STD_LOGIC;
                signal wr3_s1_non_bursting_master_requests :  STD_LOGIC;
                signal wr3_s1_reg_firsttransfer :  STD_LOGIC;
                signal wr3_s1_slavearbiterlockenable :  STD_LOGIC;
                signal wr3_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal wr3_s1_unreg_firsttransfer :  STD_LOGIC;
                signal wr3_s1_waits_for_read :  STD_LOGIC;
                signal wr3_s1_waits_for_write :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT wr3_s1_end_xfer;
    end if;

  end process;

  wr3_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_wr3_s1);
  --assign wr3_s1_readdata_from_sa = wr3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  wr3_s1_readdata_from_sa <= wr3_s1_readdata;
  internal_cpu_0_data_master_requests_wr3_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000011010000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --wr3_s1_arb_share_counter set values, which is an e_mux
  wr3_s1_arb_share_set_values <= std_logic_vector'("001");
  --wr3_s1_non_bursting_master_requests mux, which is an e_mux
  wr3_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_wr3_s1;
  --wr3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  wr3_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --wr3_s1_arb_share_counter_next_value assignment, which is an e_assign
  wr3_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(wr3_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr3_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(wr3_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr3_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --wr3_s1_allgrants all slave grants, which is an e_mux
  wr3_s1_allgrants <= wr3_s1_grant_vector;
  --wr3_s1_end_xfer assignment, which is an e_assign
  wr3_s1_end_xfer <= NOT ((wr3_s1_waits_for_read OR wr3_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_wr3_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_wr3_s1 <= wr3_s1_end_xfer AND (((NOT wr3_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --wr3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  wr3_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_wr3_s1 AND wr3_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_wr3_s1 AND NOT wr3_s1_non_bursting_master_requests));
  --wr3_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr3_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(wr3_s1_arb_counter_enable) = '1' then 
        wr3_s1_arb_share_counter <= wr3_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --wr3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr3_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((wr3_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_wr3_s1)) OR ((end_xfer_arb_share_counter_term_wr3_s1 AND NOT wr3_s1_non_bursting_master_requests)))) = '1' then 
        wr3_s1_slavearbiterlockenable <= or_reduce(wr3_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master wr3/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= wr3_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --wr3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  wr3_s1_slavearbiterlockenable2 <= or_reduce(wr3_s1_arb_share_counter_next_value);
  --cpu_0/data_master wr3/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= wr3_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --wr3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  wr3_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_wr3_s1 <= internal_cpu_0_data_master_requests_wr3_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_wr3_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_wr3_s1 <= (internal_cpu_0_data_master_granted_wr3_s1 AND cpu_0_data_master_read) AND NOT wr3_s1_waits_for_read;
  --wr3_s1_writedata mux, which is an e_mux
  wr3_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_wr3_s1 <= internal_cpu_0_data_master_qualified_request_wr3_s1;
  --cpu_0/data_master saved-grant wr3/s1, which is an e_assign
  cpu_0_data_master_saved_grant_wr3_s1 <= internal_cpu_0_data_master_requests_wr3_s1;
  --allow new arb cycle for wr3/s1, which is an e_assign
  wr3_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  wr3_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  wr3_s1_master_qreq_vector <= std_logic'('1');
  --wr3_s1_reset_n assignment, which is an e_assign
  wr3_s1_reset_n <= reset_n;
  wr3_s1_chipselect <= internal_cpu_0_data_master_granted_wr3_s1;
  --wr3_s1_firsttransfer first transaction, which is an e_assign
  wr3_s1_firsttransfer <= A_WE_StdLogic((std_logic'(wr3_s1_begins_xfer) = '1'), wr3_s1_unreg_firsttransfer, wr3_s1_reg_firsttransfer);
  --wr3_s1_unreg_firsttransfer first transaction, which is an e_assign
  wr3_s1_unreg_firsttransfer <= NOT ((wr3_s1_slavearbiterlockenable AND wr3_s1_any_continuerequest));
  --wr3_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr3_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(wr3_s1_begins_xfer) = '1' then 
        wr3_s1_reg_firsttransfer <= wr3_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --wr3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  wr3_s1_beginbursttransfer_internal <= wr3_s1_begins_xfer;
  --~wr3_s1_write_n assignment, which is an e_mux
  wr3_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_wr3_s1 AND cpu_0_data_master_write));
  shifted_address_to_wr3_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --wr3_s1_address mux, which is an e_mux
  wr3_s1_address <= A_EXT (A_SRL(shifted_address_to_wr3_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_wr3_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_wr3_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_wr3_s1_end_xfer <= wr3_s1_end_xfer;
    end if;

  end process;

  --wr3_s1_waits_for_read in a cycle, which is an e_mux
  wr3_s1_waits_for_read <= wr3_s1_in_a_read_cycle AND wr3_s1_begins_xfer;
  --wr3_s1_in_a_read_cycle assignment, which is an e_assign
  wr3_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_wr3_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= wr3_s1_in_a_read_cycle;
  --wr3_s1_waits_for_write in a cycle, which is an e_mux
  wr3_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(wr3_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --wr3_s1_in_a_write_cycle assignment, which is an e_assign
  wr3_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_wr3_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= wr3_s1_in_a_write_cycle;
  wait_for_wr3_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_wr3_s1 <= internal_cpu_0_data_master_granted_wr3_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_wr3_s1 <= internal_cpu_0_data_master_qualified_request_wr3_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_wr3_s1 <= internal_cpu_0_data_master_requests_wr3_s1;
--synthesis translate_off
    --wr3/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity wr4_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal wr4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_granted_wr4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_wr4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_wr4_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_wr4_s1 : OUT STD_LOGIC;
                 signal d1_wr4_s1_end_xfer : OUT STD_LOGIC;
                 signal wr4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal wr4_s1_chipselect : OUT STD_LOGIC;
                 signal wr4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal wr4_s1_reset_n : OUT STD_LOGIC;
                 signal wr4_s1_write_n : OUT STD_LOGIC;
                 signal wr4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity wr4_s1_arbitrator;


architecture europa of wr4_s1_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_wr4_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_wr4_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_wr4_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_wr4_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_wr4_s1 :  STD_LOGIC;
                signal shifted_address_to_wr4_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_wr4_s1_counter :  STD_LOGIC;
                signal wr4_s1_allgrants :  STD_LOGIC;
                signal wr4_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal wr4_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal wr4_s1_any_continuerequest :  STD_LOGIC;
                signal wr4_s1_arb_counter_enable :  STD_LOGIC;
                signal wr4_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr4_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr4_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal wr4_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal wr4_s1_begins_xfer :  STD_LOGIC;
                signal wr4_s1_end_xfer :  STD_LOGIC;
                signal wr4_s1_firsttransfer :  STD_LOGIC;
                signal wr4_s1_grant_vector :  STD_LOGIC;
                signal wr4_s1_in_a_read_cycle :  STD_LOGIC;
                signal wr4_s1_in_a_write_cycle :  STD_LOGIC;
                signal wr4_s1_master_qreq_vector :  STD_LOGIC;
                signal wr4_s1_non_bursting_master_requests :  STD_LOGIC;
                signal wr4_s1_reg_firsttransfer :  STD_LOGIC;
                signal wr4_s1_slavearbiterlockenable :  STD_LOGIC;
                signal wr4_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal wr4_s1_unreg_firsttransfer :  STD_LOGIC;
                signal wr4_s1_waits_for_read :  STD_LOGIC;
                signal wr4_s1_waits_for_write :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT wr4_s1_end_xfer;
    end if;

  end process;

  wr4_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_wr4_s1);
  --assign wr4_s1_readdata_from_sa = wr4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  wr4_s1_readdata_from_sa <= wr4_s1_readdata;
  internal_cpu_0_data_master_requests_wr4_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000010000010000011100000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --wr4_s1_arb_share_counter set values, which is an e_mux
  wr4_s1_arb_share_set_values <= std_logic_vector'("001");
  --wr4_s1_non_bursting_master_requests mux, which is an e_mux
  wr4_s1_non_bursting_master_requests <= internal_cpu_0_data_master_requests_wr4_s1;
  --wr4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  wr4_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --wr4_s1_arb_share_counter_next_value assignment, which is an e_assign
  wr4_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(wr4_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr4_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(wr4_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (wr4_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --wr4_s1_allgrants all slave grants, which is an e_mux
  wr4_s1_allgrants <= wr4_s1_grant_vector;
  --wr4_s1_end_xfer assignment, which is an e_assign
  wr4_s1_end_xfer <= NOT ((wr4_s1_waits_for_read OR wr4_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_wr4_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_wr4_s1 <= wr4_s1_end_xfer AND (((NOT wr4_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --wr4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  wr4_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_wr4_s1 AND wr4_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_wr4_s1 AND NOT wr4_s1_non_bursting_master_requests));
  --wr4_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr4_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(wr4_s1_arb_counter_enable) = '1' then 
        wr4_s1_arb_share_counter <= wr4_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --wr4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr4_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((wr4_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_wr4_s1)) OR ((end_xfer_arb_share_counter_term_wr4_s1 AND NOT wr4_s1_non_bursting_master_requests)))) = '1' then 
        wr4_s1_slavearbiterlockenable <= or_reduce(wr4_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master wr4/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= wr4_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --wr4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  wr4_s1_slavearbiterlockenable2 <= or_reduce(wr4_s1_arb_share_counter_next_value);
  --cpu_0/data_master wr4/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= wr4_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --wr4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  wr4_s1_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_wr4_s1 <= internal_cpu_0_data_master_requests_wr4_s1 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_0_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_wr4_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_wr4_s1 <= (internal_cpu_0_data_master_granted_wr4_s1 AND cpu_0_data_master_read) AND NOT wr4_s1_waits_for_read;
  --wr4_s1_writedata mux, which is an e_mux
  wr4_s1_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_wr4_s1 <= internal_cpu_0_data_master_qualified_request_wr4_s1;
  --cpu_0/data_master saved-grant wr4/s1, which is an e_assign
  cpu_0_data_master_saved_grant_wr4_s1 <= internal_cpu_0_data_master_requests_wr4_s1;
  --allow new arb cycle for wr4/s1, which is an e_assign
  wr4_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  wr4_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  wr4_s1_master_qreq_vector <= std_logic'('1');
  --wr4_s1_reset_n assignment, which is an e_assign
  wr4_s1_reset_n <= reset_n;
  wr4_s1_chipselect <= internal_cpu_0_data_master_granted_wr4_s1;
  --wr4_s1_firsttransfer first transaction, which is an e_assign
  wr4_s1_firsttransfer <= A_WE_StdLogic((std_logic'(wr4_s1_begins_xfer) = '1'), wr4_s1_unreg_firsttransfer, wr4_s1_reg_firsttransfer);
  --wr4_s1_unreg_firsttransfer first transaction, which is an e_assign
  wr4_s1_unreg_firsttransfer <= NOT ((wr4_s1_slavearbiterlockenable AND wr4_s1_any_continuerequest));
  --wr4_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      wr4_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(wr4_s1_begins_xfer) = '1' then 
        wr4_s1_reg_firsttransfer <= wr4_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --wr4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  wr4_s1_beginbursttransfer_internal <= wr4_s1_begins_xfer;
  --~wr4_s1_write_n assignment, which is an e_mux
  wr4_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_wr4_s1 AND cpu_0_data_master_write));
  shifted_address_to_wr4_s1_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --wr4_s1_address mux, which is an e_mux
  wr4_s1_address <= A_EXT (A_SRL(shifted_address_to_wr4_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_wr4_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_wr4_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_wr4_s1_end_xfer <= wr4_s1_end_xfer;
    end if;

  end process;

  --wr4_s1_waits_for_read in a cycle, which is an e_mux
  wr4_s1_waits_for_read <= wr4_s1_in_a_read_cycle AND wr4_s1_begins_xfer;
  --wr4_s1_in_a_read_cycle assignment, which is an e_assign
  wr4_s1_in_a_read_cycle <= internal_cpu_0_data_master_granted_wr4_s1 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= wr4_s1_in_a_read_cycle;
  --wr4_s1_waits_for_write in a cycle, which is an e_mux
  wr4_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(wr4_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --wr4_s1_in_a_write_cycle assignment, which is an e_assign
  wr4_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_wr4_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= wr4_s1_in_a_write_cycle;
  wait_for_wr4_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_wr4_s1 <= internal_cpu_0_data_master_granted_wr4_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_wr4_s1 <= internal_cpu_0_data_master_qualified_request_wr4_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_wr4_s1 <= internal_cpu_0_data_master_requests_wr4_s1;
--synthesis translate_off
    --wr4/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nios2_reset_clk_0_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity nios2_reset_clk_0_domain_synch_module;


architecture europa of nios2_reset_clk_0_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nios2 is 
        port (
              -- 1) global signals:
                 signal clk_0 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_HC_12
                 signal rxd_to_the_HC_12 : IN STD_LOGIC;
                 signal txd_from_the_HC_12 : OUT STD_LOGIC;

              -- the_US_100_UART
                 signal rxd_to_the_US_100_UART : IN STD_LOGIC;
                 signal txd_from_the_US_100_UART : OUT STD_LOGIC;

              -- the_addr
                 signal out_port_from_the_addr : OUT STD_LOGIC;

              -- the_addr2
                 signal out_port_from_the_addr2 : OUT STD_LOGIC;

              -- the_addr3
                 signal out_port_from_the_addr3 : OUT STD_LOGIC;

              -- the_addr4
                 signal out_port_from_the_addr4 : OUT STD_LOGIC;

              -- the_epcs_flash_controller_0
                 signal data0_to_the_epcs_flash_controller_0 : IN STD_LOGIC;
                 signal dclk_from_the_epcs_flash_controller_0 : OUT STD_LOGIC;
                 signal sce_from_the_epcs_flash_controller_0 : OUT STD_LOGIC;
                 signal sdo_from_the_epcs_flash_controller_0 : OUT STD_LOGIC;

              -- the_opencores_i2c_fbm320
                 signal scl_pad_io_to_and_from_the_opencores_i2c_fbm320 : INOUT STD_LOGIC;
                 signal sda_pad_io_to_and_from_the_opencores_i2c_fbm320 : INOUT STD_LOGIC;

              -- the_opencores_i2c_jy901
                 signal scl_pad_io_to_and_from_the_opencores_i2c_jy901 : INOUT STD_LOGIC;
                 signal sda_pad_io_to_and_from_the_opencores_i2c_jy901 : INOUT STD_LOGIC;

              -- the_pio_0
                 signal in_port_to_the_pio_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

              -- the_pio_1
                 signal out_port_from_the_pio_1 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

              -- the_pio_2
                 signal out_port_from_the_pio_2 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

              -- the_pio_3
                 signal out_port_from_the_pio_3 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

              -- the_pio_4
                 signal out_port_from_the_pio_4 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

              -- the_sdram_0
                 signal zs_addr_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                 signal zs_ba_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_cas_n_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_cke_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_cs_n_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_dq_to_and_from_the_sdram_0 : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal zs_dqm_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_ras_n_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_we_n_from_the_sdram_0 : OUT STD_LOGIC;

              -- the_tri_state_bridge_0_avalon_slave
                 signal address_to_the_cfi_flash_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal data_to_and_from_the_cfi_flash_0 : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal read_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                 signal select_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                 signal write_n_to_the_cfi_flash_0 : OUT STD_LOGIC;

              -- the_wr
                 signal out_port_from_the_wr : OUT STD_LOGIC;

              -- the_wr2
                 signal out_port_from_the_wr2 : OUT STD_LOGIC;

              -- the_wr3
                 signal out_port_from_the_wr3 : OUT STD_LOGIC;

              -- the_wr4
                 signal out_port_from_the_wr4 : OUT STD_LOGIC
              );
end entity nios2;


architecture europa of nios2 is
component HC_12_s1_arbitrator is 
           port (
                 -- inputs:
                    signal HC_12_s1_dataavailable : IN STD_LOGIC;
                    signal HC_12_s1_irq : IN STD_LOGIC;
                    signal HC_12_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal HC_12_s1_readyfordata : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal HC_12_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal HC_12_s1_begintransfer : OUT STD_LOGIC;
                    signal HC_12_s1_chipselect : OUT STD_LOGIC;
                    signal HC_12_s1_dataavailable_from_sa : OUT STD_LOGIC;
                    signal HC_12_s1_irq_from_sa : OUT STD_LOGIC;
                    signal HC_12_s1_read_n : OUT STD_LOGIC;
                    signal HC_12_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal HC_12_s1_readyfordata_from_sa : OUT STD_LOGIC;
                    signal HC_12_s1_reset_n : OUT STD_LOGIC;
                    signal HC_12_s1_write_n : OUT STD_LOGIC;
                    signal HC_12_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_0_data_master_granted_HC_12_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_HC_12_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_HC_12_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_HC_12_s1 : OUT STD_LOGIC;
                    signal d1_HC_12_s1_end_xfer : OUT STD_LOGIC
                 );
end component HC_12_s1_arbitrator;

component HC_12 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rxd : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal txd : OUT STD_LOGIC
                 );
end component HC_12;

component US_100_UART_s1_arbitrator is 
           port (
                 -- inputs:
                    signal US_100_UART_s1_dataavailable : IN STD_LOGIC;
                    signal US_100_UART_s1_irq : IN STD_LOGIC;
                    signal US_100_UART_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal US_100_UART_s1_readyfordata : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal US_100_UART_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal US_100_UART_s1_begintransfer : OUT STD_LOGIC;
                    signal US_100_UART_s1_chipselect : OUT STD_LOGIC;
                    signal US_100_UART_s1_dataavailable_from_sa : OUT STD_LOGIC;
                    signal US_100_UART_s1_irq_from_sa : OUT STD_LOGIC;
                    signal US_100_UART_s1_read_n : OUT STD_LOGIC;
                    signal US_100_UART_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal US_100_UART_s1_readyfordata_from_sa : OUT STD_LOGIC;
                    signal US_100_UART_s1_reset_n : OUT STD_LOGIC;
                    signal US_100_UART_s1_write_n : OUT STD_LOGIC;
                    signal US_100_UART_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_0_data_master_granted_US_100_UART_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_US_100_UART_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_US_100_UART_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_US_100_UART_s1 : OUT STD_LOGIC;
                    signal d1_US_100_UART_s1_end_xfer : OUT STD_LOGIC
                 );
end component US_100_UART_s1_arbitrator;

component US_100_UART is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rxd : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal txd : OUT STD_LOGIC
                 );
end component US_100_UART;

component addr_s1_arbitrator is 
           port (
                 -- inputs:
                    signal addr_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal addr_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal addr_s1_chipselect : OUT STD_LOGIC;
                    signal addr_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal addr_s1_reset_n : OUT STD_LOGIC;
                    signal addr_s1_write_n : OUT STD_LOGIC;
                    signal addr_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_granted_addr_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_addr_s1 : OUT STD_LOGIC;
                    signal d1_addr_s1_end_xfer : OUT STD_LOGIC
                 );
end component addr_s1_arbitrator;

component addr is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component addr;

component addr2_s1_arbitrator is 
           port (
                 -- inputs:
                    signal addr2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal addr2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal addr2_s1_chipselect : OUT STD_LOGIC;
                    signal addr2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal addr2_s1_reset_n : OUT STD_LOGIC;
                    signal addr2_s1_write_n : OUT STD_LOGIC;
                    signal addr2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_granted_addr2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_addr2_s1 : OUT STD_LOGIC;
                    signal d1_addr2_s1_end_xfer : OUT STD_LOGIC
                 );
end component addr2_s1_arbitrator;

component addr2 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component addr2;

component addr3_s1_arbitrator is 
           port (
                 -- inputs:
                    signal addr3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal addr3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal addr3_s1_chipselect : OUT STD_LOGIC;
                    signal addr3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal addr3_s1_reset_n : OUT STD_LOGIC;
                    signal addr3_s1_write_n : OUT STD_LOGIC;
                    signal addr3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_granted_addr3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_addr3_s1 : OUT STD_LOGIC;
                    signal d1_addr3_s1_end_xfer : OUT STD_LOGIC
                 );
end component addr3_s1_arbitrator;

component addr3 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component addr3;

component addr4_s1_arbitrator is 
           port (
                 -- inputs:
                    signal addr4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal addr4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal addr4_s1_chipselect : OUT STD_LOGIC;
                    signal addr4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal addr4_s1_reset_n : OUT STD_LOGIC;
                    signal addr4_s1_write_n : OUT STD_LOGIC;
                    signal addr4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_granted_addr4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_addr4_s1 : OUT STD_LOGIC;
                    signal d1_addr4_s1_end_xfer : OUT STD_LOGIC
                 );
end component addr4_s1_arbitrator;

component addr4 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component addr4;

component cpu_0_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_debugaccess : IN STD_LOGIC;
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_reset_n : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_write : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_0_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component cpu_0_jtag_debug_module_arbitrator;

component cpu_0_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal HC_12_s1_irq_from_sa : IN STD_LOGIC;
                    signal HC_12_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal US_100_UART_s1_irq_from_sa : IN STD_LOGIC;
                    signal US_100_UART_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal addr2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal addr3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal addr4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal addr_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cfi_flash_0_s1_wait_counter_eq_0 : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_byteenable_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_byteenable_sdram_0_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_granted_HC_12_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_US_100_UART_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_addr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_addr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_addr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_addr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_pio_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_pio_1_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_pio_2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_pio_3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_pio_4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_sysid_0_control_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_timer_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_wr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_wr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_wr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_wr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_HC_12_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_US_100_UART_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_addr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_1_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_sysid_0_control_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_timer_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_HC_12_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_US_100_UART_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_addr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_1_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sysid_0_control_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_timer_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_HC_12_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_US_100_UART_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_addr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_addr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_addr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_addr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_1_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_sysid_0_control_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_timer_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_wr2_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_wr3_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_wr4_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_wr_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_HC_12_s1_end_xfer : IN STD_LOGIC;
                    signal d1_US_100_UART_s1_end_xfer : IN STD_LOGIC;
                    signal d1_addr2_s1_end_xfer : IN STD_LOGIC;
                    signal d1_addr3_s1_end_xfer : IN STD_LOGIC;
                    signal d1_addr4_s1_end_xfer : IN STD_LOGIC;
                    signal d1_addr_s1_end_xfer : IN STD_LOGIC;
                    signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_epcs_flash_controller_0_epcs_control_port_end_xfer : IN STD_LOGIC;
                    signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_opencores_i2c_jy901_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_pio_0_s1_end_xfer : IN STD_LOGIC;
                    signal d1_pio_1_s1_end_xfer : IN STD_LOGIC;
                    signal d1_pio_2_s1_end_xfer : IN STD_LOGIC;
                    signal d1_pio_3_s1_end_xfer : IN STD_LOGIC;
                    signal d1_pio_4_s1_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                    signal d1_sysid_0_control_slave_end_xfer : IN STD_LOGIC;
                    signal d1_timer_0_s1_end_xfer : IN STD_LOGIC;
                    signal d1_tri_state_bridge_0_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_wr2_s1_end_xfer : IN STD_LOGIC;
                    signal d1_wr3_s1_end_xfer : IN STD_LOGIC;
                    signal d1_wr4_s1_end_xfer : IN STD_LOGIC;
                    signal d1_wr_s1_end_xfer : IN STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_irq_from_sa : IN STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_irq_from_sa : IN STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa : IN STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_irq_from_sa : IN STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa : IN STD_LOGIC;
                    signal pio_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;
                    signal sysid_0_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal timer_0_s1_irq_from_sa : IN STD_LOGIC;
                    signal timer_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal wr2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal wr3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal wr4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal wr_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_0_data_master_dbs_write_8 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_0_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_0_data_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_0_data_master_arbitrator;

component cpu_0_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal cfi_flash_0_s1_wait_counter_eq_0 : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_instruction_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_instruction_master_granted_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_instruction_master_granted_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_instruction_master_requests_cfi_flash_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port : IN STD_LOGIC;
                    signal cpu_0_instruction_master_requests_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_epcs_flash_controller_0_epcs_control_port_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                    signal d1_tri_state_bridge_0_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal incoming_data_to_and_from_the_cfi_flash_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_instruction_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_0_instruction_master_arbitrator;

component cpu_0 is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d_irq : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdatavalid : IN STD_LOGIC;
                    signal d_waitrequest : IN STD_LOGIC;
                    signal i_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_readdatavalid : IN STD_LOGIC;
                    signal i_waitrequest : IN STD_LOGIC;
                    signal jtag_debug_module_address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal jtag_debug_module_begintransfer : IN STD_LOGIC;
                    signal jtag_debug_module_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal jtag_debug_module_debugaccess : IN STD_LOGIC;
                    signal jtag_debug_module_select : IN STD_LOGIC;
                    signal jtag_debug_module_write : IN STD_LOGIC;
                    signal jtag_debug_module_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d_address : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component cpu_0;

component epcs_flash_controller_0_epcs_control_port_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_dataavailable : IN STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_endofpacket : IN STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_irq : IN STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal epcs_flash_controller_0_epcs_control_port_readyfordata : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port : OUT STD_LOGIC;
                    signal d1_epcs_flash_controller_0_epcs_control_port_end_xfer : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal epcs_flash_controller_0_epcs_control_port_chipselect : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_irq_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_read_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_reset_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_write_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_0_epcs_control_port_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component epcs_flash_controller_0_epcs_control_port_arbitrator;

component epcs_flash_controller_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data0 : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal dclk : OUT STD_LOGIC;
                    signal endofpacket : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal sce : OUT STD_LOGIC;
                    signal sdo : OUT STD_LOGIC
                 );
end component epcs_flash_controller_0;

component jtag_uart_0_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component jtag_uart_0_avalon_jtag_slave_arbitrator;

component jtag_uart_0 is 
           port (
                 -- inputs:
                    signal av_address : IN STD_LOGIC;
                    signal av_chipselect : IN STD_LOGIC;
                    signal av_read_n : IN STD_LOGIC;
                    signal av_write_n : IN STD_LOGIC;
                    signal av_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst_n : IN STD_LOGIC;

                 -- outputs:
                    signal av_irq : OUT STD_LOGIC;
                    signal av_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal av_waitrequest : OUT STD_LOGIC;
                    signal dataavailable : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component jtag_uart_0;

component opencores_i2c_fbm320_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal opencores_i2c_fbm320_avalon_slave_0_irq : IN STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal opencores_i2c_fbm320_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_irq_from_sa : OUT STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal opencores_i2c_fbm320_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa : OUT STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_write : OUT STD_LOGIC;
                    signal opencores_i2c_fbm320_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component opencores_i2c_fbm320_avalon_slave_0_arbitrator;

component opencores_i2c_fbm320 is 
           port (
                 -- inputs:
                    signal wb_adr_i : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal wb_clk_i : IN STD_LOGIC;
                    signal wb_dat_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal wb_rst_i : IN STD_LOGIC;
                    signal wb_stb_i : IN STD_LOGIC;
                    signal wb_we_i : IN STD_LOGIC;

                 -- outputs:
                    signal scl_pad_io : INOUT STD_LOGIC;
                    signal sda_pad_io : INOUT STD_LOGIC;
                    signal wb_ack_o : OUT STD_LOGIC;
                    signal wb_dat_o : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal wb_inta_o : OUT STD_LOGIC
                 );
end component opencores_i2c_fbm320;

component opencores_i2c_jy901_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal opencores_i2c_jy901_avalon_slave_0_irq : IN STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_opencores_i2c_jy901_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal opencores_i2c_jy901_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_irq_from_sa : OUT STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal opencores_i2c_jy901_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa : OUT STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_write : OUT STD_LOGIC;
                    signal opencores_i2c_jy901_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component opencores_i2c_jy901_avalon_slave_0_arbitrator;

component opencores_i2c_jy901 is 
           port (
                 -- inputs:
                    signal wb_adr_i : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal wb_clk_i : IN STD_LOGIC;
                    signal wb_dat_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal wb_rst_i : IN STD_LOGIC;
                    signal wb_stb_i : IN STD_LOGIC;
                    signal wb_we_i : IN STD_LOGIC;

                 -- outputs:
                    signal scl_pad_io : INOUT STD_LOGIC;
                    signal sda_pad_io : INOUT STD_LOGIC;
                    signal wb_ack_o : OUT STD_LOGIC;
                    signal wb_dat_o : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal wb_inta_o : OUT STD_LOGIC
                 );
end component opencores_i2c_jy901;

component pio_0_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal pio_0_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_pio_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_0_s1 : OUT STD_LOGIC;
                    signal d1_pio_0_s1_end_xfer : OUT STD_LOGIC;
                    signal pio_0_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal pio_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_0_s1_reset_n : OUT STD_LOGIC
                 );
end component pio_0_s1_arbitrator;

component pio_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_0;

component pio_1_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_1_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_pio_1_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_1_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_1_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_1_s1 : OUT STD_LOGIC;
                    signal d1_pio_1_s1_end_xfer : OUT STD_LOGIC;
                    signal pio_1_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal pio_1_s1_chipselect : OUT STD_LOGIC;
                    signal pio_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_1_s1_reset_n : OUT STD_LOGIC;
                    signal pio_1_s1_write_n : OUT STD_LOGIC;
                    signal pio_1_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_1_s1_arbitrator;

component pio_1 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_1;

component pio_2_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_pio_2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_2_s1 : OUT STD_LOGIC;
                    signal d1_pio_2_s1_end_xfer : OUT STD_LOGIC;
                    signal pio_2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal pio_2_s1_chipselect : OUT STD_LOGIC;
                    signal pio_2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_2_s1_reset_n : OUT STD_LOGIC;
                    signal pio_2_s1_write_n : OUT STD_LOGIC;
                    signal pio_2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_2_s1_arbitrator;

component pio_2 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_2;

component pio_3_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_pio_3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_3_s1 : OUT STD_LOGIC;
                    signal d1_pio_3_s1_end_xfer : OUT STD_LOGIC;
                    signal pio_3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal pio_3_s1_chipselect : OUT STD_LOGIC;
                    signal pio_3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_3_s1_reset_n : OUT STD_LOGIC;
                    signal pio_3_s1_write_n : OUT STD_LOGIC;
                    signal pio_3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_3_s1_arbitrator;

component pio_3 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_3;

component pio_4_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_pio_4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_pio_4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_pio_4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_pio_4_s1 : OUT STD_LOGIC;
                    signal d1_pio_4_s1_end_xfer : OUT STD_LOGIC;
                    signal pio_4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal pio_4_s1_chipselect : OUT STD_LOGIC;
                    signal pio_4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pio_4_s1_reset_n : OUT STD_LOGIC;
                    signal pio_4_s1_write_n : OUT STD_LOGIC;
                    signal pio_4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_4_s1_arbitrator;

component pio_4 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pio_4;

component sdram_0_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_0_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_readdatavalid : IN STD_LOGIC;
                    signal sdram_0_s1_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_byteenable_sdram_0_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                    signal d1_sdram_0_s1_end_xfer : OUT STD_LOGIC;
                    signal sdram_0_s1_address : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal sdram_0_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal sdram_0_s1_chipselect : OUT STD_LOGIC;
                    signal sdram_0_s1_read_n : OUT STD_LOGIC;
                    signal sdram_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_reset_n : OUT STD_LOGIC;
                    signal sdram_0_s1_waitrequest_from_sa : OUT STD_LOGIC;
                    signal sdram_0_s1_write_n : OUT STD_LOGIC;
                    signal sdram_0_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sdram_0_s1_arbitrator;

component sdram_0 is 
           port (
                 -- inputs:
                    signal az_addr : IN STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal az_be_n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal az_cs : IN STD_LOGIC;
                    signal az_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal az_rd_n : IN STD_LOGIC;
                    signal az_wr_n : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal za_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal za_valid : OUT STD_LOGIC;
                    signal za_waitrequest : OUT STD_LOGIC;
                    signal zs_addr : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                    signal zs_ba : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n : OUT STD_LOGIC;
                    signal zs_cke : OUT STD_LOGIC;
                    signal zs_cs_n : OUT STD_LOGIC;
                    signal zs_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n : OUT STD_LOGIC;
                    signal zs_we_n : OUT STD_LOGIC
                 );
end component sdram_0;

component sysid_0_control_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sysid_0_control_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_granted_sysid_0_control_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_sysid_0_control_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sysid_0_control_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_sysid_0_control_slave : OUT STD_LOGIC;
                    signal d1_sysid_0_control_slave_end_xfer : OUT STD_LOGIC;
                    signal sysid_0_control_slave_address : OUT STD_LOGIC;
                    signal sysid_0_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal sysid_0_control_slave_reset_n : OUT STD_LOGIC
                 );
end component sysid_0_control_slave_arbitrator;

component sysid_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC;
                    signal clock : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component sysid_0;

component timer_0_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal timer_0_s1_irq : IN STD_LOGIC;
                    signal timer_0_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_granted_timer_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_timer_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_timer_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_timer_0_s1 : OUT STD_LOGIC;
                    signal d1_timer_0_s1_end_xfer : OUT STD_LOGIC;
                    signal timer_0_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal timer_0_s1_chipselect : OUT STD_LOGIC;
                    signal timer_0_s1_irq_from_sa : OUT STD_LOGIC;
                    signal timer_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal timer_0_s1_reset_n : OUT STD_LOGIC;
                    signal timer_0_s1_write_n : OUT STD_LOGIC;
                    signal timer_0_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component timer_0_s1_arbitrator;

component timer_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component timer_0;

component tri_state_bridge_0_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_dbs_write_8 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal address_to_the_cfi_flash_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal cfi_flash_0_s1_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_byteenable_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_granted_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_granted_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_requests_cfi_flash_0_s1 : OUT STD_LOGIC;
                    signal d1_tri_state_bridge_0_avalon_slave_end_xfer : OUT STD_LOGIC;
                    signal data_to_and_from_the_cfi_flash_0 : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal incoming_data_to_and_from_the_cfi_flash_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal read_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                    signal select_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                    signal write_n_to_the_cfi_flash_0 : OUT STD_LOGIC
                 );
end component tri_state_bridge_0_avalon_slave_arbitrator;

component tri_state_bridge_0 is 
end component tri_state_bridge_0;

component tri_state_bridge_0_bridge_arbitrator is 
end component tri_state_bridge_0_bridge_arbitrator;

component wr_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal wr_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_granted_wr_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_wr_s1 : OUT STD_LOGIC;
                    signal d1_wr_s1_end_xfer : OUT STD_LOGIC;
                    signal wr_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal wr_s1_chipselect : OUT STD_LOGIC;
                    signal wr_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal wr_s1_reset_n : OUT STD_LOGIC;
                    signal wr_s1_write_n : OUT STD_LOGIC;
                    signal wr_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr_s1_arbitrator;

component wr is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr;

component wr2_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal wr2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_granted_wr2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr2_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_wr2_s1 : OUT STD_LOGIC;
                    signal d1_wr2_s1_end_xfer : OUT STD_LOGIC;
                    signal wr2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal wr2_s1_chipselect : OUT STD_LOGIC;
                    signal wr2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal wr2_s1_reset_n : OUT STD_LOGIC;
                    signal wr2_s1_write_n : OUT STD_LOGIC;
                    signal wr2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr2_s1_arbitrator;

component wr2 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr2;

component wr3_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal wr3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_granted_wr3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr3_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_wr3_s1 : OUT STD_LOGIC;
                    signal d1_wr3_s1_end_xfer : OUT STD_LOGIC;
                    signal wr3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal wr3_s1_chipselect : OUT STD_LOGIC;
                    signal wr3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal wr3_s1_reset_n : OUT STD_LOGIC;
                    signal wr3_s1_write_n : OUT STD_LOGIC;
                    signal wr3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr3_s1_arbitrator;

component wr3 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr3;

component wr4_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal wr4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_granted_wr4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_wr4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_wr4_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_wr4_s1 : OUT STD_LOGIC;
                    signal d1_wr4_s1_end_xfer : OUT STD_LOGIC;
                    signal wr4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal wr4_s1_chipselect : OUT STD_LOGIC;
                    signal wr4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal wr4_s1_reset_n : OUT STD_LOGIC;
                    signal wr4_s1_write_n : OUT STD_LOGIC;
                    signal wr4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr4_s1_arbitrator;

component wr4 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component wr4;

component nios2_reset_clk_0_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component nios2_reset_clk_0_domain_synch_module;

                signal HC_12_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal HC_12_s1_begintransfer :  STD_LOGIC;
                signal HC_12_s1_chipselect :  STD_LOGIC;
                signal HC_12_s1_dataavailable :  STD_LOGIC;
                signal HC_12_s1_dataavailable_from_sa :  STD_LOGIC;
                signal HC_12_s1_irq :  STD_LOGIC;
                signal HC_12_s1_irq_from_sa :  STD_LOGIC;
                signal HC_12_s1_read_n :  STD_LOGIC;
                signal HC_12_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal HC_12_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal HC_12_s1_readyfordata :  STD_LOGIC;
                signal HC_12_s1_readyfordata_from_sa :  STD_LOGIC;
                signal HC_12_s1_reset_n :  STD_LOGIC;
                signal HC_12_s1_write_n :  STD_LOGIC;
                signal HC_12_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal US_100_UART_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal US_100_UART_s1_begintransfer :  STD_LOGIC;
                signal US_100_UART_s1_chipselect :  STD_LOGIC;
                signal US_100_UART_s1_dataavailable :  STD_LOGIC;
                signal US_100_UART_s1_dataavailable_from_sa :  STD_LOGIC;
                signal US_100_UART_s1_irq :  STD_LOGIC;
                signal US_100_UART_s1_irq_from_sa :  STD_LOGIC;
                signal US_100_UART_s1_read_n :  STD_LOGIC;
                signal US_100_UART_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal US_100_UART_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal US_100_UART_s1_readyfordata :  STD_LOGIC;
                signal US_100_UART_s1_readyfordata_from_sa :  STD_LOGIC;
                signal US_100_UART_s1_reset_n :  STD_LOGIC;
                signal US_100_UART_s1_write_n :  STD_LOGIC;
                signal US_100_UART_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal addr2_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal addr2_s1_chipselect :  STD_LOGIC;
                signal addr2_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr2_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr2_s1_reset_n :  STD_LOGIC;
                signal addr2_s1_write_n :  STD_LOGIC;
                signal addr2_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr3_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal addr3_s1_chipselect :  STD_LOGIC;
                signal addr3_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr3_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr3_s1_reset_n :  STD_LOGIC;
                signal addr3_s1_write_n :  STD_LOGIC;
                signal addr3_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr4_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal addr4_s1_chipselect :  STD_LOGIC;
                signal addr4_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr4_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr4_s1_reset_n :  STD_LOGIC;
                signal addr4_s1_write_n :  STD_LOGIC;
                signal addr4_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal addr_s1_chipselect :  STD_LOGIC;
                signal addr_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal addr_s1_reset_n :  STD_LOGIC;
                signal addr_s1_write_n :  STD_LOGIC;
                signal addr_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cfi_flash_0_s1_wait_counter_eq_0 :  STD_LOGIC;
                signal clk_0_reset_n :  STD_LOGIC;
                signal cpu_0_data_master_address :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_0_data_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_0_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_data_master_byteenable_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_sdram_0_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_write_16 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal cpu_0_data_master_dbs_write_8 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cpu_0_data_master_debugaccess :  STD_LOGIC;
                signal cpu_0_data_master_granted_HC_12_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_US_100_UART_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_addr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_addr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_addr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_addr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_granted_pio_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_pio_1_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_pio_2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_pio_3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_pio_4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_sysid_0_control_slave :  STD_LOGIC;
                signal cpu_0_data_master_granted_timer_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_wr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_wr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_wr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_wr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_data_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_qualified_request_HC_12_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_US_100_UART_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_addr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_addr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_addr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_addr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_pio_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_pio_1_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_pio_2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_pio_3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_pio_4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_sysid_0_control_slave :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_timer_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_wr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_wr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_wr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_wr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_HC_12_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_US_100_UART_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_addr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_addr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_addr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_addr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_pio_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_pio_1_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_pio_2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_pio_3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_pio_4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_sysid_0_control_slave :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_timer_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_wr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_wr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_wr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_wr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_data_master_readdatavalid :  STD_LOGIC;
                signal cpu_0_data_master_requests_HC_12_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_US_100_UART_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_addr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_addr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_addr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_addr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_requests_pio_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_pio_1_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_pio_2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_pio_3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_pio_4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_sysid_0_control_slave :  STD_LOGIC;
                signal cpu_0_data_master_requests_timer_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_wr2_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_wr3_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_wr4_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_wr_s1 :  STD_LOGIC;
                signal cpu_0_data_master_waitrequest :  STD_LOGIC;
                signal cpu_0_data_master_write :  STD_LOGIC;
                signal cpu_0_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_instruction_master_address :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_0_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_granted_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_instruction_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_instruction_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_read :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register :  STD_LOGIC;
                signal cpu_0_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_instruction_master_readdatavalid :  STD_LOGIC;
                signal cpu_0_instruction_master_requests_cfi_flash_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port :  STD_LOGIC;
                signal cpu_0_instruction_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_waitrequest :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal cpu_0_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_jtag_debug_module_chipselect :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_jtag_debug_module_reset_n :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_write :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal d1_HC_12_s1_end_xfer :  STD_LOGIC;
                signal d1_US_100_UART_s1_end_xfer :  STD_LOGIC;
                signal d1_addr2_s1_end_xfer :  STD_LOGIC;
                signal d1_addr3_s1_end_xfer :  STD_LOGIC;
                signal d1_addr4_s1_end_xfer :  STD_LOGIC;
                signal d1_addr_s1_end_xfer :  STD_LOGIC;
                signal d1_cpu_0_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_epcs_flash_controller_0_epcs_control_port_end_xfer :  STD_LOGIC;
                signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_opencores_i2c_jy901_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_pio_0_s1_end_xfer :  STD_LOGIC;
                signal d1_pio_1_s1_end_xfer :  STD_LOGIC;
                signal d1_pio_2_s1_end_xfer :  STD_LOGIC;
                signal d1_pio_3_s1_end_xfer :  STD_LOGIC;
                signal d1_pio_4_s1_end_xfer :  STD_LOGIC;
                signal d1_sdram_0_s1_end_xfer :  STD_LOGIC;
                signal d1_sysid_0_control_slave_end_xfer :  STD_LOGIC;
                signal d1_timer_0_s1_end_xfer :  STD_LOGIC;
                signal d1_tri_state_bridge_0_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_wr2_s1_end_xfer :  STD_LOGIC;
                signal d1_wr3_s1_end_xfer :  STD_LOGIC;
                signal d1_wr4_s1_end_xfer :  STD_LOGIC;
                signal d1_wr_s1_end_xfer :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_chipselect :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_dataavailable :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_endofpacket :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_irq :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_irq_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_read_n :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal epcs_flash_controller_0_epcs_control_port_readyfordata :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_reset_n :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_write_n :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal incoming_data_to_and_from_the_cfi_flash_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_address_to_the_cfi_flash_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_dclk_from_the_epcs_flash_controller_0 :  STD_LOGIC;
                signal internal_out_port_from_the_addr :  STD_LOGIC;
                signal internal_out_port_from_the_addr2 :  STD_LOGIC;
                signal internal_out_port_from_the_addr3 :  STD_LOGIC;
                signal internal_out_port_from_the_addr4 :  STD_LOGIC;
                signal internal_out_port_from_the_pio_1 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal internal_out_port_from_the_pio_2 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal internal_out_port_from_the_pio_3 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal internal_out_port_from_the_pio_4 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal internal_out_port_from_the_wr :  STD_LOGIC;
                signal internal_out_port_from_the_wr2 :  STD_LOGIC;
                signal internal_out_port_from_the_wr3 :  STD_LOGIC;
                signal internal_out_port_from_the_wr4 :  STD_LOGIC;
                signal internal_read_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal internal_sce_from_the_epcs_flash_controller_0 :  STD_LOGIC;
                signal internal_sdo_from_the_epcs_flash_controller_0 :  STD_LOGIC;
                signal internal_select_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal internal_txd_from_the_HC_12 :  STD_LOGIC;
                signal internal_txd_from_the_US_100_UART :  STD_LOGIC;
                signal internal_write_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal internal_zs_addr_from_the_sdram_0 :  STD_LOGIC_VECTOR (12 DOWNTO 0);
                signal internal_zs_ba_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_cas_n_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_cke_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_cs_n_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_dqm_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_ras_n_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_we_n_from_the_sdram_0 :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_address :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_irq :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal module_input6 :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_fbm320_avalon_slave_0_chipselect :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_irq :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_irq_from_sa :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal opencores_i2c_fbm320_avalon_slave_0_reset :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_write :  STD_LOGIC;
                signal opencores_i2c_fbm320_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal opencores_i2c_jy901_avalon_slave_0_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal opencores_i2c_jy901_avalon_slave_0_chipselect :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_irq :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_irq_from_sa :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal opencores_i2c_jy901_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal opencores_i2c_jy901_avalon_slave_0_reset :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_write :  STD_LOGIC;
                signal opencores_i2c_jy901_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pio_0_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pio_0_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_0_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_0_s1_reset_n :  STD_LOGIC;
                signal pio_1_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pio_1_s1_chipselect :  STD_LOGIC;
                signal pio_1_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_1_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_1_s1_reset_n :  STD_LOGIC;
                signal pio_1_s1_write_n :  STD_LOGIC;
                signal pio_1_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_2_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pio_2_s1_chipselect :  STD_LOGIC;
                signal pio_2_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_2_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_2_s1_reset_n :  STD_LOGIC;
                signal pio_2_s1_write_n :  STD_LOGIC;
                signal pio_2_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_3_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pio_3_s1_chipselect :  STD_LOGIC;
                signal pio_3_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_3_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_3_s1_reset_n :  STD_LOGIC;
                signal pio_3_s1_write_n :  STD_LOGIC;
                signal pio_3_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_4_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pio_4_s1_chipselect :  STD_LOGIC;
                signal pio_4_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_4_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pio_4_s1_reset_n :  STD_LOGIC;
                signal pio_4_s1_write_n :  STD_LOGIC;
                signal pio_4_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal reset_n_sources :  STD_LOGIC;
                signal sdram_0_s1_address :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal sdram_0_s1_byteenable_n :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_chipselect :  STD_LOGIC;
                signal sdram_0_s1_read_n :  STD_LOGIC;
                signal sdram_0_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_0_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_0_s1_readdatavalid :  STD_LOGIC;
                signal sdram_0_s1_reset_n :  STD_LOGIC;
                signal sdram_0_s1_waitrequest :  STD_LOGIC;
                signal sdram_0_s1_waitrequest_from_sa :  STD_LOGIC;
                signal sdram_0_s1_write_n :  STD_LOGIC;
                signal sdram_0_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sysid_0_control_slave_address :  STD_LOGIC;
                signal sysid_0_control_slave_clock :  STD_LOGIC;
                signal sysid_0_control_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal sysid_0_control_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal sysid_0_control_slave_reset_n :  STD_LOGIC;
                signal timer_0_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_0_s1_chipselect :  STD_LOGIC;
                signal timer_0_s1_irq :  STD_LOGIC;
                signal timer_0_s1_irq_from_sa :  STD_LOGIC;
                signal timer_0_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal timer_0_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal timer_0_s1_reset_n :  STD_LOGIC;
                signal timer_0_s1_write_n :  STD_LOGIC;
                signal timer_0_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal wr2_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal wr2_s1_chipselect :  STD_LOGIC;
                signal wr2_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr2_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr2_s1_reset_n :  STD_LOGIC;
                signal wr2_s1_write_n :  STD_LOGIC;
                signal wr2_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr3_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal wr3_s1_chipselect :  STD_LOGIC;
                signal wr3_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr3_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr3_s1_reset_n :  STD_LOGIC;
                signal wr3_s1_write_n :  STD_LOGIC;
                signal wr3_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr4_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal wr4_s1_chipselect :  STD_LOGIC;
                signal wr4_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr4_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr4_s1_reset_n :  STD_LOGIC;
                signal wr4_s1_write_n :  STD_LOGIC;
                signal wr4_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal wr_s1_chipselect :  STD_LOGIC;
                signal wr_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal wr_s1_reset_n :  STD_LOGIC;
                signal wr_s1_write_n :  STD_LOGIC;
                signal wr_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

  --the_HC_12_s1, which is an e_instance
  the_HC_12_s1 : HC_12_s1_arbitrator
    port map(
      HC_12_s1_address => HC_12_s1_address,
      HC_12_s1_begintransfer => HC_12_s1_begintransfer,
      HC_12_s1_chipselect => HC_12_s1_chipselect,
      HC_12_s1_dataavailable_from_sa => HC_12_s1_dataavailable_from_sa,
      HC_12_s1_irq_from_sa => HC_12_s1_irq_from_sa,
      HC_12_s1_read_n => HC_12_s1_read_n,
      HC_12_s1_readdata_from_sa => HC_12_s1_readdata_from_sa,
      HC_12_s1_readyfordata_from_sa => HC_12_s1_readyfordata_from_sa,
      HC_12_s1_reset_n => HC_12_s1_reset_n,
      HC_12_s1_write_n => HC_12_s1_write_n,
      HC_12_s1_writedata => HC_12_s1_writedata,
      cpu_0_data_master_granted_HC_12_s1 => cpu_0_data_master_granted_HC_12_s1,
      cpu_0_data_master_qualified_request_HC_12_s1 => cpu_0_data_master_qualified_request_HC_12_s1,
      cpu_0_data_master_read_data_valid_HC_12_s1 => cpu_0_data_master_read_data_valid_HC_12_s1,
      cpu_0_data_master_requests_HC_12_s1 => cpu_0_data_master_requests_HC_12_s1,
      d1_HC_12_s1_end_xfer => d1_HC_12_s1_end_xfer,
      HC_12_s1_dataavailable => HC_12_s1_dataavailable,
      HC_12_s1_irq => HC_12_s1_irq,
      HC_12_s1_readdata => HC_12_s1_readdata,
      HC_12_s1_readyfordata => HC_12_s1_readyfordata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_HC_12, which is an e_ptf_instance
  the_HC_12 : HC_12
    port map(
      dataavailable => HC_12_s1_dataavailable,
      irq => HC_12_s1_irq,
      readdata => HC_12_s1_readdata,
      readyfordata => HC_12_s1_readyfordata,
      txd => internal_txd_from_the_HC_12,
      address => HC_12_s1_address,
      begintransfer => HC_12_s1_begintransfer,
      chipselect => HC_12_s1_chipselect,
      clk => clk_0,
      read_n => HC_12_s1_read_n,
      reset_n => HC_12_s1_reset_n,
      rxd => rxd_to_the_HC_12,
      write_n => HC_12_s1_write_n,
      writedata => HC_12_s1_writedata
    );


  --the_US_100_UART_s1, which is an e_instance
  the_US_100_UART_s1 : US_100_UART_s1_arbitrator
    port map(
      US_100_UART_s1_address => US_100_UART_s1_address,
      US_100_UART_s1_begintransfer => US_100_UART_s1_begintransfer,
      US_100_UART_s1_chipselect => US_100_UART_s1_chipselect,
      US_100_UART_s1_dataavailable_from_sa => US_100_UART_s1_dataavailable_from_sa,
      US_100_UART_s1_irq_from_sa => US_100_UART_s1_irq_from_sa,
      US_100_UART_s1_read_n => US_100_UART_s1_read_n,
      US_100_UART_s1_readdata_from_sa => US_100_UART_s1_readdata_from_sa,
      US_100_UART_s1_readyfordata_from_sa => US_100_UART_s1_readyfordata_from_sa,
      US_100_UART_s1_reset_n => US_100_UART_s1_reset_n,
      US_100_UART_s1_write_n => US_100_UART_s1_write_n,
      US_100_UART_s1_writedata => US_100_UART_s1_writedata,
      cpu_0_data_master_granted_US_100_UART_s1 => cpu_0_data_master_granted_US_100_UART_s1,
      cpu_0_data_master_qualified_request_US_100_UART_s1 => cpu_0_data_master_qualified_request_US_100_UART_s1,
      cpu_0_data_master_read_data_valid_US_100_UART_s1 => cpu_0_data_master_read_data_valid_US_100_UART_s1,
      cpu_0_data_master_requests_US_100_UART_s1 => cpu_0_data_master_requests_US_100_UART_s1,
      d1_US_100_UART_s1_end_xfer => d1_US_100_UART_s1_end_xfer,
      US_100_UART_s1_dataavailable => US_100_UART_s1_dataavailable,
      US_100_UART_s1_irq => US_100_UART_s1_irq,
      US_100_UART_s1_readdata => US_100_UART_s1_readdata,
      US_100_UART_s1_readyfordata => US_100_UART_s1_readyfordata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_US_100_UART, which is an e_ptf_instance
  the_US_100_UART : US_100_UART
    port map(
      dataavailable => US_100_UART_s1_dataavailable,
      irq => US_100_UART_s1_irq,
      readdata => US_100_UART_s1_readdata,
      readyfordata => US_100_UART_s1_readyfordata,
      txd => internal_txd_from_the_US_100_UART,
      address => US_100_UART_s1_address,
      begintransfer => US_100_UART_s1_begintransfer,
      chipselect => US_100_UART_s1_chipselect,
      clk => clk_0,
      read_n => US_100_UART_s1_read_n,
      reset_n => US_100_UART_s1_reset_n,
      rxd => rxd_to_the_US_100_UART,
      write_n => US_100_UART_s1_write_n,
      writedata => US_100_UART_s1_writedata
    );


  --the_addr_s1, which is an e_instance
  the_addr_s1 : addr_s1_arbitrator
    port map(
      addr_s1_address => addr_s1_address,
      addr_s1_chipselect => addr_s1_chipselect,
      addr_s1_readdata_from_sa => addr_s1_readdata_from_sa,
      addr_s1_reset_n => addr_s1_reset_n,
      addr_s1_write_n => addr_s1_write_n,
      addr_s1_writedata => addr_s1_writedata,
      cpu_0_data_master_granted_addr_s1 => cpu_0_data_master_granted_addr_s1,
      cpu_0_data_master_qualified_request_addr_s1 => cpu_0_data_master_qualified_request_addr_s1,
      cpu_0_data_master_read_data_valid_addr_s1 => cpu_0_data_master_read_data_valid_addr_s1,
      cpu_0_data_master_requests_addr_s1 => cpu_0_data_master_requests_addr_s1,
      d1_addr_s1_end_xfer => d1_addr_s1_end_xfer,
      addr_s1_readdata => addr_s1_readdata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_addr, which is an e_ptf_instance
  the_addr : addr
    port map(
      out_port => internal_out_port_from_the_addr,
      readdata => addr_s1_readdata,
      address => addr_s1_address,
      chipselect => addr_s1_chipselect,
      clk => clk_0,
      reset_n => addr_s1_reset_n,
      write_n => addr_s1_write_n,
      writedata => addr_s1_writedata
    );


  --the_addr2_s1, which is an e_instance
  the_addr2_s1 : addr2_s1_arbitrator
    port map(
      addr2_s1_address => addr2_s1_address,
      addr2_s1_chipselect => addr2_s1_chipselect,
      addr2_s1_readdata_from_sa => addr2_s1_readdata_from_sa,
      addr2_s1_reset_n => addr2_s1_reset_n,
      addr2_s1_write_n => addr2_s1_write_n,
      addr2_s1_writedata => addr2_s1_writedata,
      cpu_0_data_master_granted_addr2_s1 => cpu_0_data_master_granted_addr2_s1,
      cpu_0_data_master_qualified_request_addr2_s1 => cpu_0_data_master_qualified_request_addr2_s1,
      cpu_0_data_master_read_data_valid_addr2_s1 => cpu_0_data_master_read_data_valid_addr2_s1,
      cpu_0_data_master_requests_addr2_s1 => cpu_0_data_master_requests_addr2_s1,
      d1_addr2_s1_end_xfer => d1_addr2_s1_end_xfer,
      addr2_s1_readdata => addr2_s1_readdata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_addr2, which is an e_ptf_instance
  the_addr2 : addr2
    port map(
      out_port => internal_out_port_from_the_addr2,
      readdata => addr2_s1_readdata,
      address => addr2_s1_address,
      chipselect => addr2_s1_chipselect,
      clk => clk_0,
      reset_n => addr2_s1_reset_n,
      write_n => addr2_s1_write_n,
      writedata => addr2_s1_writedata
    );


  --the_addr3_s1, which is an e_instance
  the_addr3_s1 : addr3_s1_arbitrator
    port map(
      addr3_s1_address => addr3_s1_address,
      addr3_s1_chipselect => addr3_s1_chipselect,
      addr3_s1_readdata_from_sa => addr3_s1_readdata_from_sa,
      addr3_s1_reset_n => addr3_s1_reset_n,
      addr3_s1_write_n => addr3_s1_write_n,
      addr3_s1_writedata => addr3_s1_writedata,
      cpu_0_data_master_granted_addr3_s1 => cpu_0_data_master_granted_addr3_s1,
      cpu_0_data_master_qualified_request_addr3_s1 => cpu_0_data_master_qualified_request_addr3_s1,
      cpu_0_data_master_read_data_valid_addr3_s1 => cpu_0_data_master_read_data_valid_addr3_s1,
      cpu_0_data_master_requests_addr3_s1 => cpu_0_data_master_requests_addr3_s1,
      d1_addr3_s1_end_xfer => d1_addr3_s1_end_xfer,
      addr3_s1_readdata => addr3_s1_readdata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_addr3, which is an e_ptf_instance
  the_addr3 : addr3
    port map(
      out_port => internal_out_port_from_the_addr3,
      readdata => addr3_s1_readdata,
      address => addr3_s1_address,
      chipselect => addr3_s1_chipselect,
      clk => clk_0,
      reset_n => addr3_s1_reset_n,
      write_n => addr3_s1_write_n,
      writedata => addr3_s1_writedata
    );


  --the_addr4_s1, which is an e_instance
  the_addr4_s1 : addr4_s1_arbitrator
    port map(
      addr4_s1_address => addr4_s1_address,
      addr4_s1_chipselect => addr4_s1_chipselect,
      addr4_s1_readdata_from_sa => addr4_s1_readdata_from_sa,
      addr4_s1_reset_n => addr4_s1_reset_n,
      addr4_s1_write_n => addr4_s1_write_n,
      addr4_s1_writedata => addr4_s1_writedata,
      cpu_0_data_master_granted_addr4_s1 => cpu_0_data_master_granted_addr4_s1,
      cpu_0_data_master_qualified_request_addr4_s1 => cpu_0_data_master_qualified_request_addr4_s1,
      cpu_0_data_master_read_data_valid_addr4_s1 => cpu_0_data_master_read_data_valid_addr4_s1,
      cpu_0_data_master_requests_addr4_s1 => cpu_0_data_master_requests_addr4_s1,
      d1_addr4_s1_end_xfer => d1_addr4_s1_end_xfer,
      addr4_s1_readdata => addr4_s1_readdata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_addr4, which is an e_ptf_instance
  the_addr4 : addr4
    port map(
      out_port => internal_out_port_from_the_addr4,
      readdata => addr4_s1_readdata,
      address => addr4_s1_address,
      chipselect => addr4_s1_chipselect,
      clk => clk_0,
      reset_n => addr4_s1_reset_n,
      write_n => addr4_s1_write_n,
      writedata => addr4_s1_writedata
    );


  --the_cpu_0_jtag_debug_module, which is an e_instance
  the_cpu_0_jtag_debug_module : cpu_0_jtag_debug_module_arbitrator
    port map(
      cpu_0_data_master_granted_cpu_0_jtag_debug_module => cpu_0_data_master_granted_cpu_0_jtag_debug_module,
      cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_data_master_requests_cpu_0_jtag_debug_module => cpu_0_data_master_requests_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_granted_cpu_0_jtag_debug_module => cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_requests_cpu_0_jtag_debug_module => cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
      cpu_0_jtag_debug_module_address => cpu_0_jtag_debug_module_address,
      cpu_0_jtag_debug_module_begintransfer => cpu_0_jtag_debug_module_begintransfer,
      cpu_0_jtag_debug_module_byteenable => cpu_0_jtag_debug_module_byteenable,
      cpu_0_jtag_debug_module_chipselect => cpu_0_jtag_debug_module_chipselect,
      cpu_0_jtag_debug_module_debugaccess => cpu_0_jtag_debug_module_debugaccess,
      cpu_0_jtag_debug_module_readdata_from_sa => cpu_0_jtag_debug_module_readdata_from_sa,
      cpu_0_jtag_debug_module_reset_n => cpu_0_jtag_debug_module_reset_n,
      cpu_0_jtag_debug_module_resetrequest_from_sa => cpu_0_jtag_debug_module_resetrequest_from_sa,
      cpu_0_jtag_debug_module_write => cpu_0_jtag_debug_module_write,
      cpu_0_jtag_debug_module_writedata => cpu_0_jtag_debug_module_writedata,
      d1_cpu_0_jtag_debug_module_end_xfer => d1_cpu_0_jtag_debug_module_end_xfer,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_debugaccess => cpu_0_data_master_debugaccess,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_jtag_debug_module_readdata => cpu_0_jtag_debug_module_readdata,
      cpu_0_jtag_debug_module_resetrequest => cpu_0_jtag_debug_module_resetrequest,
      reset_n => clk_0_reset_n
    );


  --the_cpu_0_data_master, which is an e_instance
  the_cpu_0_data_master : cpu_0_data_master_arbitrator
    port map(
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_dbs_address => cpu_0_data_master_dbs_address,
      cpu_0_data_master_dbs_write_16 => cpu_0_data_master_dbs_write_16,
      cpu_0_data_master_dbs_write_8 => cpu_0_data_master_dbs_write_8,
      cpu_0_data_master_irq => cpu_0_data_master_irq,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_readdata => cpu_0_data_master_readdata,
      cpu_0_data_master_readdatavalid => cpu_0_data_master_readdatavalid,
      cpu_0_data_master_waitrequest => cpu_0_data_master_waitrequest,
      HC_12_s1_irq_from_sa => HC_12_s1_irq_from_sa,
      HC_12_s1_readdata_from_sa => HC_12_s1_readdata_from_sa,
      US_100_UART_s1_irq_from_sa => US_100_UART_s1_irq_from_sa,
      US_100_UART_s1_readdata_from_sa => US_100_UART_s1_readdata_from_sa,
      addr2_s1_readdata_from_sa => addr2_s1_readdata_from_sa,
      addr3_s1_readdata_from_sa => addr3_s1_readdata_from_sa,
      addr4_s1_readdata_from_sa => addr4_s1_readdata_from_sa,
      addr_s1_readdata_from_sa => addr_s1_readdata_from_sa,
      cfi_flash_0_s1_wait_counter_eq_0 => cfi_flash_0_s1_wait_counter_eq_0,
      clk => clk_0,
      cpu_0_data_master_address => cpu_0_data_master_address,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_byteenable_cfi_flash_0_s1 => cpu_0_data_master_byteenable_cfi_flash_0_s1,
      cpu_0_data_master_byteenable_sdram_0_s1 => cpu_0_data_master_byteenable_sdram_0_s1,
      cpu_0_data_master_granted_HC_12_s1 => cpu_0_data_master_granted_HC_12_s1,
      cpu_0_data_master_granted_US_100_UART_s1 => cpu_0_data_master_granted_US_100_UART_s1,
      cpu_0_data_master_granted_addr2_s1 => cpu_0_data_master_granted_addr2_s1,
      cpu_0_data_master_granted_addr3_s1 => cpu_0_data_master_granted_addr3_s1,
      cpu_0_data_master_granted_addr4_s1 => cpu_0_data_master_granted_addr4_s1,
      cpu_0_data_master_granted_addr_s1 => cpu_0_data_master_granted_addr_s1,
      cpu_0_data_master_granted_cfi_flash_0_s1 => cpu_0_data_master_granted_cfi_flash_0_s1,
      cpu_0_data_master_granted_cpu_0_jtag_debug_module => cpu_0_data_master_granted_cpu_0_jtag_debug_module,
      cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port,
      cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0,
      cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0,
      cpu_0_data_master_granted_pio_0_s1 => cpu_0_data_master_granted_pio_0_s1,
      cpu_0_data_master_granted_pio_1_s1 => cpu_0_data_master_granted_pio_1_s1,
      cpu_0_data_master_granted_pio_2_s1 => cpu_0_data_master_granted_pio_2_s1,
      cpu_0_data_master_granted_pio_3_s1 => cpu_0_data_master_granted_pio_3_s1,
      cpu_0_data_master_granted_pio_4_s1 => cpu_0_data_master_granted_pio_4_s1,
      cpu_0_data_master_granted_sdram_0_s1 => cpu_0_data_master_granted_sdram_0_s1,
      cpu_0_data_master_granted_sysid_0_control_slave => cpu_0_data_master_granted_sysid_0_control_slave,
      cpu_0_data_master_granted_timer_0_s1 => cpu_0_data_master_granted_timer_0_s1,
      cpu_0_data_master_granted_wr2_s1 => cpu_0_data_master_granted_wr2_s1,
      cpu_0_data_master_granted_wr3_s1 => cpu_0_data_master_granted_wr3_s1,
      cpu_0_data_master_granted_wr4_s1 => cpu_0_data_master_granted_wr4_s1,
      cpu_0_data_master_granted_wr_s1 => cpu_0_data_master_granted_wr_s1,
      cpu_0_data_master_qualified_request_HC_12_s1 => cpu_0_data_master_qualified_request_HC_12_s1,
      cpu_0_data_master_qualified_request_US_100_UART_s1 => cpu_0_data_master_qualified_request_US_100_UART_s1,
      cpu_0_data_master_qualified_request_addr2_s1 => cpu_0_data_master_qualified_request_addr2_s1,
      cpu_0_data_master_qualified_request_addr3_s1 => cpu_0_data_master_qualified_request_addr3_s1,
      cpu_0_data_master_qualified_request_addr4_s1 => cpu_0_data_master_qualified_request_addr4_s1,
      cpu_0_data_master_qualified_request_addr_s1 => cpu_0_data_master_qualified_request_addr_s1,
      cpu_0_data_master_qualified_request_cfi_flash_0_s1 => cpu_0_data_master_qualified_request_cfi_flash_0_s1,
      cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
      cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0,
      cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0,
      cpu_0_data_master_qualified_request_pio_0_s1 => cpu_0_data_master_qualified_request_pio_0_s1,
      cpu_0_data_master_qualified_request_pio_1_s1 => cpu_0_data_master_qualified_request_pio_1_s1,
      cpu_0_data_master_qualified_request_pio_2_s1 => cpu_0_data_master_qualified_request_pio_2_s1,
      cpu_0_data_master_qualified_request_pio_3_s1 => cpu_0_data_master_qualified_request_pio_3_s1,
      cpu_0_data_master_qualified_request_pio_4_s1 => cpu_0_data_master_qualified_request_pio_4_s1,
      cpu_0_data_master_qualified_request_sdram_0_s1 => cpu_0_data_master_qualified_request_sdram_0_s1,
      cpu_0_data_master_qualified_request_sysid_0_control_slave => cpu_0_data_master_qualified_request_sysid_0_control_slave,
      cpu_0_data_master_qualified_request_timer_0_s1 => cpu_0_data_master_qualified_request_timer_0_s1,
      cpu_0_data_master_qualified_request_wr2_s1 => cpu_0_data_master_qualified_request_wr2_s1,
      cpu_0_data_master_qualified_request_wr3_s1 => cpu_0_data_master_qualified_request_wr3_s1,
      cpu_0_data_master_qualified_request_wr4_s1 => cpu_0_data_master_qualified_request_wr4_s1,
      cpu_0_data_master_qualified_request_wr_s1 => cpu_0_data_master_qualified_request_wr_s1,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_HC_12_s1 => cpu_0_data_master_read_data_valid_HC_12_s1,
      cpu_0_data_master_read_data_valid_US_100_UART_s1 => cpu_0_data_master_read_data_valid_US_100_UART_s1,
      cpu_0_data_master_read_data_valid_addr2_s1 => cpu_0_data_master_read_data_valid_addr2_s1,
      cpu_0_data_master_read_data_valid_addr3_s1 => cpu_0_data_master_read_data_valid_addr3_s1,
      cpu_0_data_master_read_data_valid_addr4_s1 => cpu_0_data_master_read_data_valid_addr4_s1,
      cpu_0_data_master_read_data_valid_addr_s1 => cpu_0_data_master_read_data_valid_addr_s1,
      cpu_0_data_master_read_data_valid_cfi_flash_0_s1 => cpu_0_data_master_read_data_valid_cfi_flash_0_s1,
      cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
      cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0,
      cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0,
      cpu_0_data_master_read_data_valid_pio_0_s1 => cpu_0_data_master_read_data_valid_pio_0_s1,
      cpu_0_data_master_read_data_valid_pio_1_s1 => cpu_0_data_master_read_data_valid_pio_1_s1,
      cpu_0_data_master_read_data_valid_pio_2_s1 => cpu_0_data_master_read_data_valid_pio_2_s1,
      cpu_0_data_master_read_data_valid_pio_3_s1 => cpu_0_data_master_read_data_valid_pio_3_s1,
      cpu_0_data_master_read_data_valid_pio_4_s1 => cpu_0_data_master_read_data_valid_pio_4_s1,
      cpu_0_data_master_read_data_valid_sdram_0_s1 => cpu_0_data_master_read_data_valid_sdram_0_s1,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_read_data_valid_sysid_0_control_slave => cpu_0_data_master_read_data_valid_sysid_0_control_slave,
      cpu_0_data_master_read_data_valid_timer_0_s1 => cpu_0_data_master_read_data_valid_timer_0_s1,
      cpu_0_data_master_read_data_valid_wr2_s1 => cpu_0_data_master_read_data_valid_wr2_s1,
      cpu_0_data_master_read_data_valid_wr3_s1 => cpu_0_data_master_read_data_valid_wr3_s1,
      cpu_0_data_master_read_data_valid_wr4_s1 => cpu_0_data_master_read_data_valid_wr4_s1,
      cpu_0_data_master_read_data_valid_wr_s1 => cpu_0_data_master_read_data_valid_wr_s1,
      cpu_0_data_master_requests_HC_12_s1 => cpu_0_data_master_requests_HC_12_s1,
      cpu_0_data_master_requests_US_100_UART_s1 => cpu_0_data_master_requests_US_100_UART_s1,
      cpu_0_data_master_requests_addr2_s1 => cpu_0_data_master_requests_addr2_s1,
      cpu_0_data_master_requests_addr3_s1 => cpu_0_data_master_requests_addr3_s1,
      cpu_0_data_master_requests_addr4_s1 => cpu_0_data_master_requests_addr4_s1,
      cpu_0_data_master_requests_addr_s1 => cpu_0_data_master_requests_addr_s1,
      cpu_0_data_master_requests_cfi_flash_0_s1 => cpu_0_data_master_requests_cfi_flash_0_s1,
      cpu_0_data_master_requests_cpu_0_jtag_debug_module => cpu_0_data_master_requests_cpu_0_jtag_debug_module,
      cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port,
      cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0,
      cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0,
      cpu_0_data_master_requests_pio_0_s1 => cpu_0_data_master_requests_pio_0_s1,
      cpu_0_data_master_requests_pio_1_s1 => cpu_0_data_master_requests_pio_1_s1,
      cpu_0_data_master_requests_pio_2_s1 => cpu_0_data_master_requests_pio_2_s1,
      cpu_0_data_master_requests_pio_3_s1 => cpu_0_data_master_requests_pio_3_s1,
      cpu_0_data_master_requests_pio_4_s1 => cpu_0_data_master_requests_pio_4_s1,
      cpu_0_data_master_requests_sdram_0_s1 => cpu_0_data_master_requests_sdram_0_s1,
      cpu_0_data_master_requests_sysid_0_control_slave => cpu_0_data_master_requests_sysid_0_control_slave,
      cpu_0_data_master_requests_timer_0_s1 => cpu_0_data_master_requests_timer_0_s1,
      cpu_0_data_master_requests_wr2_s1 => cpu_0_data_master_requests_wr2_s1,
      cpu_0_data_master_requests_wr3_s1 => cpu_0_data_master_requests_wr3_s1,
      cpu_0_data_master_requests_wr4_s1 => cpu_0_data_master_requests_wr4_s1,
      cpu_0_data_master_requests_wr_s1 => cpu_0_data_master_requests_wr_s1,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      cpu_0_jtag_debug_module_readdata_from_sa => cpu_0_jtag_debug_module_readdata_from_sa,
      d1_HC_12_s1_end_xfer => d1_HC_12_s1_end_xfer,
      d1_US_100_UART_s1_end_xfer => d1_US_100_UART_s1_end_xfer,
      d1_addr2_s1_end_xfer => d1_addr2_s1_end_xfer,
      d1_addr3_s1_end_xfer => d1_addr3_s1_end_xfer,
      d1_addr4_s1_end_xfer => d1_addr4_s1_end_xfer,
      d1_addr_s1_end_xfer => d1_addr_s1_end_xfer,
      d1_cpu_0_jtag_debug_module_end_xfer => d1_cpu_0_jtag_debug_module_end_xfer,
      d1_epcs_flash_controller_0_epcs_control_port_end_xfer => d1_epcs_flash_controller_0_epcs_control_port_end_xfer,
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer => d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
      d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer => d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer,
      d1_opencores_i2c_jy901_avalon_slave_0_end_xfer => d1_opencores_i2c_jy901_avalon_slave_0_end_xfer,
      d1_pio_0_s1_end_xfer => d1_pio_0_s1_end_xfer,
      d1_pio_1_s1_end_xfer => d1_pio_1_s1_end_xfer,
      d1_pio_2_s1_end_xfer => d1_pio_2_s1_end_xfer,
      d1_pio_3_s1_end_xfer => d1_pio_3_s1_end_xfer,
      d1_pio_4_s1_end_xfer => d1_pio_4_s1_end_xfer,
      d1_sdram_0_s1_end_xfer => d1_sdram_0_s1_end_xfer,
      d1_sysid_0_control_slave_end_xfer => d1_sysid_0_control_slave_end_xfer,
      d1_timer_0_s1_end_xfer => d1_timer_0_s1_end_xfer,
      d1_tri_state_bridge_0_avalon_slave_end_xfer => d1_tri_state_bridge_0_avalon_slave_end_xfer,
      d1_wr2_s1_end_xfer => d1_wr2_s1_end_xfer,
      d1_wr3_s1_end_xfer => d1_wr3_s1_end_xfer,
      d1_wr4_s1_end_xfer => d1_wr4_s1_end_xfer,
      d1_wr_s1_end_xfer => d1_wr_s1_end_xfer,
      epcs_flash_controller_0_epcs_control_port_irq_from_sa => epcs_flash_controller_0_epcs_control_port_irq_from_sa,
      epcs_flash_controller_0_epcs_control_port_readdata_from_sa => epcs_flash_controller_0_epcs_control_port_readdata_from_sa,
      incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 => incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0,
      jtag_uart_0_avalon_jtag_slave_irq_from_sa => jtag_uart_0_avalon_jtag_slave_irq_from_sa,
      jtag_uart_0_avalon_jtag_slave_readdata_from_sa => jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
      opencores_i2c_fbm320_avalon_slave_0_irq_from_sa => opencores_i2c_fbm320_avalon_slave_0_irq_from_sa,
      opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa => opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa,
      opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa => opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa,
      opencores_i2c_jy901_avalon_slave_0_irq_from_sa => opencores_i2c_jy901_avalon_slave_0_irq_from_sa,
      opencores_i2c_jy901_avalon_slave_0_readdata_from_sa => opencores_i2c_jy901_avalon_slave_0_readdata_from_sa,
      opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa => opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa,
      pio_0_s1_readdata_from_sa => pio_0_s1_readdata_from_sa,
      pio_1_s1_readdata_from_sa => pio_1_s1_readdata_from_sa,
      pio_2_s1_readdata_from_sa => pio_2_s1_readdata_from_sa,
      pio_3_s1_readdata_from_sa => pio_3_s1_readdata_from_sa,
      pio_4_s1_readdata_from_sa => pio_4_s1_readdata_from_sa,
      reset_n => clk_0_reset_n,
      sdram_0_s1_readdata_from_sa => sdram_0_s1_readdata_from_sa,
      sdram_0_s1_waitrequest_from_sa => sdram_0_s1_waitrequest_from_sa,
      sysid_0_control_slave_readdata_from_sa => sysid_0_control_slave_readdata_from_sa,
      timer_0_s1_irq_from_sa => timer_0_s1_irq_from_sa,
      timer_0_s1_readdata_from_sa => timer_0_s1_readdata_from_sa,
      wr2_s1_readdata_from_sa => wr2_s1_readdata_from_sa,
      wr3_s1_readdata_from_sa => wr3_s1_readdata_from_sa,
      wr4_s1_readdata_from_sa => wr4_s1_readdata_from_sa,
      wr_s1_readdata_from_sa => wr_s1_readdata_from_sa
    );


  --the_cpu_0_instruction_master, which is an e_instance
  the_cpu_0_instruction_master : cpu_0_instruction_master_arbitrator
    port map(
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_dbs_address => cpu_0_instruction_master_dbs_address,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_readdata => cpu_0_instruction_master_readdata,
      cpu_0_instruction_master_readdatavalid => cpu_0_instruction_master_readdatavalid,
      cpu_0_instruction_master_waitrequest => cpu_0_instruction_master_waitrequest,
      cfi_flash_0_s1_wait_counter_eq_0 => cfi_flash_0_s1_wait_counter_eq_0,
      clk => clk_0,
      cpu_0_instruction_master_address => cpu_0_instruction_master_address,
      cpu_0_instruction_master_granted_cfi_flash_0_s1 => cpu_0_instruction_master_granted_cfi_flash_0_s1,
      cpu_0_instruction_master_granted_cpu_0_jtag_debug_module => cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_granted_sdram_0_s1 => cpu_0_instruction_master_granted_sdram_0_s1,
      cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 => cpu_0_instruction_master_qualified_request_cfi_flash_0_s1,
      cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_qualified_request_sdram_0_s1 => cpu_0_instruction_master_qualified_request_sdram_0_s1,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 => cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1,
      cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1 => cpu_0_instruction_master_read_data_valid_sdram_0_s1,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_instruction_master_requests_cfi_flash_0_s1 => cpu_0_instruction_master_requests_cfi_flash_0_s1,
      cpu_0_instruction_master_requests_cpu_0_jtag_debug_module => cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_requests_sdram_0_s1 => cpu_0_instruction_master_requests_sdram_0_s1,
      cpu_0_jtag_debug_module_readdata_from_sa => cpu_0_jtag_debug_module_readdata_from_sa,
      d1_cpu_0_jtag_debug_module_end_xfer => d1_cpu_0_jtag_debug_module_end_xfer,
      d1_epcs_flash_controller_0_epcs_control_port_end_xfer => d1_epcs_flash_controller_0_epcs_control_port_end_xfer,
      d1_sdram_0_s1_end_xfer => d1_sdram_0_s1_end_xfer,
      d1_tri_state_bridge_0_avalon_slave_end_xfer => d1_tri_state_bridge_0_avalon_slave_end_xfer,
      epcs_flash_controller_0_epcs_control_port_readdata_from_sa => epcs_flash_controller_0_epcs_control_port_readdata_from_sa,
      incoming_data_to_and_from_the_cfi_flash_0 => incoming_data_to_and_from_the_cfi_flash_0,
      reset_n => clk_0_reset_n,
      sdram_0_s1_readdata_from_sa => sdram_0_s1_readdata_from_sa,
      sdram_0_s1_waitrequest_from_sa => sdram_0_s1_waitrequest_from_sa
    );


  --the_cpu_0, which is an e_ptf_instance
  the_cpu_0 : cpu_0
    port map(
      d_address => cpu_0_data_master_address,
      d_byteenable => cpu_0_data_master_byteenable,
      d_read => cpu_0_data_master_read,
      d_write => cpu_0_data_master_write,
      d_writedata => cpu_0_data_master_writedata,
      i_address => cpu_0_instruction_master_address,
      i_read => cpu_0_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => cpu_0_data_master_debugaccess,
      jtag_debug_module_readdata => cpu_0_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => cpu_0_jtag_debug_module_resetrequest,
      clk => clk_0,
      d_irq => cpu_0_data_master_irq,
      d_readdata => cpu_0_data_master_readdata,
      d_readdatavalid => cpu_0_data_master_readdatavalid,
      d_waitrequest => cpu_0_data_master_waitrequest,
      i_readdata => cpu_0_instruction_master_readdata,
      i_readdatavalid => cpu_0_instruction_master_readdatavalid,
      i_waitrequest => cpu_0_instruction_master_waitrequest,
      jtag_debug_module_address => cpu_0_jtag_debug_module_address,
      jtag_debug_module_begintransfer => cpu_0_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => cpu_0_jtag_debug_module_byteenable,
      jtag_debug_module_debugaccess => cpu_0_jtag_debug_module_debugaccess,
      jtag_debug_module_select => cpu_0_jtag_debug_module_chipselect,
      jtag_debug_module_write => cpu_0_jtag_debug_module_write,
      jtag_debug_module_writedata => cpu_0_jtag_debug_module_writedata,
      reset_n => cpu_0_jtag_debug_module_reset_n
    );


  --the_epcs_flash_controller_0_epcs_control_port, which is an e_instance
  the_epcs_flash_controller_0_epcs_control_port : epcs_flash_controller_0_epcs_control_port_arbitrator
    port map(
      cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port,
      cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
      cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
      cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port => cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
      cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port => cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port,
      d1_epcs_flash_controller_0_epcs_control_port_end_xfer => d1_epcs_flash_controller_0_epcs_control_port_end_xfer,
      epcs_flash_controller_0_epcs_control_port_address => epcs_flash_controller_0_epcs_control_port_address,
      epcs_flash_controller_0_epcs_control_port_chipselect => epcs_flash_controller_0_epcs_control_port_chipselect,
      epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa => epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa,
      epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa => epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa,
      epcs_flash_controller_0_epcs_control_port_irq_from_sa => epcs_flash_controller_0_epcs_control_port_irq_from_sa,
      epcs_flash_controller_0_epcs_control_port_read_n => epcs_flash_controller_0_epcs_control_port_read_n,
      epcs_flash_controller_0_epcs_control_port_readdata_from_sa => epcs_flash_controller_0_epcs_control_port_readdata_from_sa,
      epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa => epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa,
      epcs_flash_controller_0_epcs_control_port_reset_n => epcs_flash_controller_0_epcs_control_port_reset_n,
      epcs_flash_controller_0_epcs_control_port_write_n => epcs_flash_controller_0_epcs_control_port_write_n,
      epcs_flash_controller_0_epcs_control_port_writedata => epcs_flash_controller_0_epcs_control_port_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      epcs_flash_controller_0_epcs_control_port_dataavailable => epcs_flash_controller_0_epcs_control_port_dataavailable,
      epcs_flash_controller_0_epcs_control_port_endofpacket => epcs_flash_controller_0_epcs_control_port_endofpacket,
      epcs_flash_controller_0_epcs_control_port_irq => epcs_flash_controller_0_epcs_control_port_irq,
      epcs_flash_controller_0_epcs_control_port_readdata => epcs_flash_controller_0_epcs_control_port_readdata,
      epcs_flash_controller_0_epcs_control_port_readyfordata => epcs_flash_controller_0_epcs_control_port_readyfordata,
      reset_n => clk_0_reset_n
    );


  --the_epcs_flash_controller_0, which is an e_ptf_instance
  the_epcs_flash_controller_0 : epcs_flash_controller_0
    port map(
      dataavailable => epcs_flash_controller_0_epcs_control_port_dataavailable,
      dclk => internal_dclk_from_the_epcs_flash_controller_0,
      endofpacket => epcs_flash_controller_0_epcs_control_port_endofpacket,
      irq => epcs_flash_controller_0_epcs_control_port_irq,
      readdata => epcs_flash_controller_0_epcs_control_port_readdata,
      readyfordata => epcs_flash_controller_0_epcs_control_port_readyfordata,
      sce => internal_sce_from_the_epcs_flash_controller_0,
      sdo => internal_sdo_from_the_epcs_flash_controller_0,
      address => epcs_flash_controller_0_epcs_control_port_address,
      chipselect => epcs_flash_controller_0_epcs_control_port_chipselect,
      clk => clk_0,
      data0 => data0_to_the_epcs_flash_controller_0,
      read_n => epcs_flash_controller_0_epcs_control_port_read_n,
      reset_n => epcs_flash_controller_0_epcs_control_port_reset_n,
      write_n => epcs_flash_controller_0_epcs_control_port_write_n,
      writedata => epcs_flash_controller_0_epcs_control_port_writedata
    );


  --the_jtag_uart_0_avalon_jtag_slave, which is an e_instance
  the_jtag_uart_0_avalon_jtag_slave : jtag_uart_0_avalon_jtag_slave_arbitrator
    port map(
      cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer => d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
      jtag_uart_0_avalon_jtag_slave_address => jtag_uart_0_avalon_jtag_slave_address,
      jtag_uart_0_avalon_jtag_slave_chipselect => jtag_uart_0_avalon_jtag_slave_chipselect,
      jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa => jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
      jtag_uart_0_avalon_jtag_slave_irq_from_sa => jtag_uart_0_avalon_jtag_slave_irq_from_sa,
      jtag_uart_0_avalon_jtag_slave_read_n => jtag_uart_0_avalon_jtag_slave_read_n,
      jtag_uart_0_avalon_jtag_slave_readdata_from_sa => jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa => jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
      jtag_uart_0_avalon_jtag_slave_reset_n => jtag_uart_0_avalon_jtag_slave_reset_n,
      jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
      jtag_uart_0_avalon_jtag_slave_write_n => jtag_uart_0_avalon_jtag_slave_write_n,
      jtag_uart_0_avalon_jtag_slave_writedata => jtag_uart_0_avalon_jtag_slave_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      jtag_uart_0_avalon_jtag_slave_dataavailable => jtag_uart_0_avalon_jtag_slave_dataavailable,
      jtag_uart_0_avalon_jtag_slave_irq => jtag_uart_0_avalon_jtag_slave_irq,
      jtag_uart_0_avalon_jtag_slave_readdata => jtag_uart_0_avalon_jtag_slave_readdata,
      jtag_uart_0_avalon_jtag_slave_readyfordata => jtag_uart_0_avalon_jtag_slave_readyfordata,
      jtag_uart_0_avalon_jtag_slave_waitrequest => jtag_uart_0_avalon_jtag_slave_waitrequest,
      reset_n => clk_0_reset_n
    );


  --the_jtag_uart_0, which is an e_ptf_instance
  the_jtag_uart_0 : jtag_uart_0
    port map(
      av_irq => jtag_uart_0_avalon_jtag_slave_irq,
      av_readdata => jtag_uart_0_avalon_jtag_slave_readdata,
      av_waitrequest => jtag_uart_0_avalon_jtag_slave_waitrequest,
      dataavailable => jtag_uart_0_avalon_jtag_slave_dataavailable,
      readyfordata => jtag_uart_0_avalon_jtag_slave_readyfordata,
      av_address => jtag_uart_0_avalon_jtag_slave_address,
      av_chipselect => jtag_uart_0_avalon_jtag_slave_chipselect,
      av_read_n => jtag_uart_0_avalon_jtag_slave_read_n,
      av_write_n => jtag_uart_0_avalon_jtag_slave_write_n,
      av_writedata => jtag_uart_0_avalon_jtag_slave_writedata,
      clk => clk_0,
      rst_n => jtag_uart_0_avalon_jtag_slave_reset_n
    );


  --the_opencores_i2c_fbm320_avalon_slave_0, which is an e_instance
  the_opencores_i2c_fbm320_avalon_slave_0 : opencores_i2c_fbm320_avalon_slave_0_arbitrator
    port map(
      cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_granted_opencores_i2c_fbm320_avalon_slave_0,
      cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_qualified_request_opencores_i2c_fbm320_avalon_slave_0,
      cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_read_data_valid_opencores_i2c_fbm320_avalon_slave_0,
      cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0 => cpu_0_data_master_requests_opencores_i2c_fbm320_avalon_slave_0,
      d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer => d1_opencores_i2c_fbm320_avalon_slave_0_end_xfer,
      opencores_i2c_fbm320_avalon_slave_0_address => opencores_i2c_fbm320_avalon_slave_0_address,
      opencores_i2c_fbm320_avalon_slave_0_chipselect => opencores_i2c_fbm320_avalon_slave_0_chipselect,
      opencores_i2c_fbm320_avalon_slave_0_irq_from_sa => opencores_i2c_fbm320_avalon_slave_0_irq_from_sa,
      opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa => opencores_i2c_fbm320_avalon_slave_0_readdata_from_sa,
      opencores_i2c_fbm320_avalon_slave_0_reset => opencores_i2c_fbm320_avalon_slave_0_reset,
      opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa => opencores_i2c_fbm320_avalon_slave_0_waitrequest_n_from_sa,
      opencores_i2c_fbm320_avalon_slave_0_write => opencores_i2c_fbm320_avalon_slave_0_write,
      opencores_i2c_fbm320_avalon_slave_0_writedata => opencores_i2c_fbm320_avalon_slave_0_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      opencores_i2c_fbm320_avalon_slave_0_irq => opencores_i2c_fbm320_avalon_slave_0_irq,
      opencores_i2c_fbm320_avalon_slave_0_readdata => opencores_i2c_fbm320_avalon_slave_0_readdata,
      opencores_i2c_fbm320_avalon_slave_0_waitrequest_n => opencores_i2c_fbm320_avalon_slave_0_waitrequest_n,
      reset_n => clk_0_reset_n
    );


  --the_opencores_i2c_fbm320, which is an e_ptf_instance
  the_opencores_i2c_fbm320 : opencores_i2c_fbm320
    port map(
      scl_pad_io => scl_pad_io_to_and_from_the_opencores_i2c_fbm320,
      sda_pad_io => sda_pad_io_to_and_from_the_opencores_i2c_fbm320,
      wb_ack_o => opencores_i2c_fbm320_avalon_slave_0_waitrequest_n,
      wb_dat_o => opencores_i2c_fbm320_avalon_slave_0_readdata,
      wb_inta_o => opencores_i2c_fbm320_avalon_slave_0_irq,
      wb_adr_i => opencores_i2c_fbm320_avalon_slave_0_address,
      wb_clk_i => clk_0,
      wb_dat_i => opencores_i2c_fbm320_avalon_slave_0_writedata,
      wb_rst_i => opencores_i2c_fbm320_avalon_slave_0_reset,
      wb_stb_i => opencores_i2c_fbm320_avalon_slave_0_chipselect,
      wb_we_i => opencores_i2c_fbm320_avalon_slave_0_write
    );


  --the_opencores_i2c_jy901_avalon_slave_0, which is an e_instance
  the_opencores_i2c_jy901_avalon_slave_0 : opencores_i2c_jy901_avalon_slave_0_arbitrator
    port map(
      cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_granted_opencores_i2c_jy901_avalon_slave_0,
      cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_qualified_request_opencores_i2c_jy901_avalon_slave_0,
      cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_read_data_valid_opencores_i2c_jy901_avalon_slave_0,
      cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0 => cpu_0_data_master_requests_opencores_i2c_jy901_avalon_slave_0,
      d1_opencores_i2c_jy901_avalon_slave_0_end_xfer => d1_opencores_i2c_jy901_avalon_slave_0_end_xfer,
      opencores_i2c_jy901_avalon_slave_0_address => opencores_i2c_jy901_avalon_slave_0_address,
      opencores_i2c_jy901_avalon_slave_0_chipselect => opencores_i2c_jy901_avalon_slave_0_chipselect,
      opencores_i2c_jy901_avalon_slave_0_irq_from_sa => opencores_i2c_jy901_avalon_slave_0_irq_from_sa,
      opencores_i2c_jy901_avalon_slave_0_readdata_from_sa => opencores_i2c_jy901_avalon_slave_0_readdata_from_sa,
      opencores_i2c_jy901_avalon_slave_0_reset => opencores_i2c_jy901_avalon_slave_0_reset,
      opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa => opencores_i2c_jy901_avalon_slave_0_waitrequest_n_from_sa,
      opencores_i2c_jy901_avalon_slave_0_write => opencores_i2c_jy901_avalon_slave_0_write,
      opencores_i2c_jy901_avalon_slave_0_writedata => opencores_i2c_jy901_avalon_slave_0_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      opencores_i2c_jy901_avalon_slave_0_irq => opencores_i2c_jy901_avalon_slave_0_irq,
      opencores_i2c_jy901_avalon_slave_0_readdata => opencores_i2c_jy901_avalon_slave_0_readdata,
      opencores_i2c_jy901_avalon_slave_0_waitrequest_n => opencores_i2c_jy901_avalon_slave_0_waitrequest_n,
      reset_n => clk_0_reset_n
    );


  --the_opencores_i2c_jy901, which is an e_ptf_instance
  the_opencores_i2c_jy901 : opencores_i2c_jy901
    port map(
      scl_pad_io => scl_pad_io_to_and_from_the_opencores_i2c_jy901,
      sda_pad_io => sda_pad_io_to_and_from_the_opencores_i2c_jy901,
      wb_ack_o => opencores_i2c_jy901_avalon_slave_0_waitrequest_n,
      wb_dat_o => opencores_i2c_jy901_avalon_slave_0_readdata,
      wb_inta_o => opencores_i2c_jy901_avalon_slave_0_irq,
      wb_adr_i => opencores_i2c_jy901_avalon_slave_0_address,
      wb_clk_i => clk_0,
      wb_dat_i => opencores_i2c_jy901_avalon_slave_0_writedata,
      wb_rst_i => opencores_i2c_jy901_avalon_slave_0_reset,
      wb_stb_i => opencores_i2c_jy901_avalon_slave_0_chipselect,
      wb_we_i => opencores_i2c_jy901_avalon_slave_0_write
    );


  --the_pio_0_s1, which is an e_instance
  the_pio_0_s1 : pio_0_s1_arbitrator
    port map(
      cpu_0_data_master_granted_pio_0_s1 => cpu_0_data_master_granted_pio_0_s1,
      cpu_0_data_master_qualified_request_pio_0_s1 => cpu_0_data_master_qualified_request_pio_0_s1,
      cpu_0_data_master_read_data_valid_pio_0_s1 => cpu_0_data_master_read_data_valid_pio_0_s1,
      cpu_0_data_master_requests_pio_0_s1 => cpu_0_data_master_requests_pio_0_s1,
      d1_pio_0_s1_end_xfer => d1_pio_0_s1_end_xfer,
      pio_0_s1_address => pio_0_s1_address,
      pio_0_s1_readdata_from_sa => pio_0_s1_readdata_from_sa,
      pio_0_s1_reset_n => pio_0_s1_reset_n,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      pio_0_s1_readdata => pio_0_s1_readdata,
      reset_n => clk_0_reset_n
    );


  --the_pio_0, which is an e_ptf_instance
  the_pio_0 : pio_0
    port map(
      readdata => pio_0_s1_readdata,
      address => pio_0_s1_address,
      clk => clk_0,
      in_port => in_port_to_the_pio_0,
      reset_n => pio_0_s1_reset_n
    );


  --the_pio_1_s1, which is an e_instance
  the_pio_1_s1 : pio_1_s1_arbitrator
    port map(
      cpu_0_data_master_granted_pio_1_s1 => cpu_0_data_master_granted_pio_1_s1,
      cpu_0_data_master_qualified_request_pio_1_s1 => cpu_0_data_master_qualified_request_pio_1_s1,
      cpu_0_data_master_read_data_valid_pio_1_s1 => cpu_0_data_master_read_data_valid_pio_1_s1,
      cpu_0_data_master_requests_pio_1_s1 => cpu_0_data_master_requests_pio_1_s1,
      d1_pio_1_s1_end_xfer => d1_pio_1_s1_end_xfer,
      pio_1_s1_address => pio_1_s1_address,
      pio_1_s1_chipselect => pio_1_s1_chipselect,
      pio_1_s1_readdata_from_sa => pio_1_s1_readdata_from_sa,
      pio_1_s1_reset_n => pio_1_s1_reset_n,
      pio_1_s1_write_n => pio_1_s1_write_n,
      pio_1_s1_writedata => pio_1_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      pio_1_s1_readdata => pio_1_s1_readdata,
      reset_n => clk_0_reset_n
    );


  --the_pio_1, which is an e_ptf_instance
  the_pio_1 : pio_1
    port map(
      out_port => internal_out_port_from_the_pio_1,
      readdata => pio_1_s1_readdata,
      address => pio_1_s1_address,
      chipselect => pio_1_s1_chipselect,
      clk => clk_0,
      reset_n => pio_1_s1_reset_n,
      write_n => pio_1_s1_write_n,
      writedata => pio_1_s1_writedata
    );


  --the_pio_2_s1, which is an e_instance
  the_pio_2_s1 : pio_2_s1_arbitrator
    port map(
      cpu_0_data_master_granted_pio_2_s1 => cpu_0_data_master_granted_pio_2_s1,
      cpu_0_data_master_qualified_request_pio_2_s1 => cpu_0_data_master_qualified_request_pio_2_s1,
      cpu_0_data_master_read_data_valid_pio_2_s1 => cpu_0_data_master_read_data_valid_pio_2_s1,
      cpu_0_data_master_requests_pio_2_s1 => cpu_0_data_master_requests_pio_2_s1,
      d1_pio_2_s1_end_xfer => d1_pio_2_s1_end_xfer,
      pio_2_s1_address => pio_2_s1_address,
      pio_2_s1_chipselect => pio_2_s1_chipselect,
      pio_2_s1_readdata_from_sa => pio_2_s1_readdata_from_sa,
      pio_2_s1_reset_n => pio_2_s1_reset_n,
      pio_2_s1_write_n => pio_2_s1_write_n,
      pio_2_s1_writedata => pio_2_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      pio_2_s1_readdata => pio_2_s1_readdata,
      reset_n => clk_0_reset_n
    );


  --the_pio_2, which is an e_ptf_instance
  the_pio_2 : pio_2
    port map(
      out_port => internal_out_port_from_the_pio_2,
      readdata => pio_2_s1_readdata,
      address => pio_2_s1_address,
      chipselect => pio_2_s1_chipselect,
      clk => clk_0,
      reset_n => pio_2_s1_reset_n,
      write_n => pio_2_s1_write_n,
      writedata => pio_2_s1_writedata
    );


  --the_pio_3_s1, which is an e_instance
  the_pio_3_s1 : pio_3_s1_arbitrator
    port map(
      cpu_0_data_master_granted_pio_3_s1 => cpu_0_data_master_granted_pio_3_s1,
      cpu_0_data_master_qualified_request_pio_3_s1 => cpu_0_data_master_qualified_request_pio_3_s1,
      cpu_0_data_master_read_data_valid_pio_3_s1 => cpu_0_data_master_read_data_valid_pio_3_s1,
      cpu_0_data_master_requests_pio_3_s1 => cpu_0_data_master_requests_pio_3_s1,
      d1_pio_3_s1_end_xfer => d1_pio_3_s1_end_xfer,
      pio_3_s1_address => pio_3_s1_address,
      pio_3_s1_chipselect => pio_3_s1_chipselect,
      pio_3_s1_readdata_from_sa => pio_3_s1_readdata_from_sa,
      pio_3_s1_reset_n => pio_3_s1_reset_n,
      pio_3_s1_write_n => pio_3_s1_write_n,
      pio_3_s1_writedata => pio_3_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      pio_3_s1_readdata => pio_3_s1_readdata,
      reset_n => clk_0_reset_n
    );


  --the_pio_3, which is an e_ptf_instance
  the_pio_3 : pio_3
    port map(
      out_port => internal_out_port_from_the_pio_3,
      readdata => pio_3_s1_readdata,
      address => pio_3_s1_address,
      chipselect => pio_3_s1_chipselect,
      clk => clk_0,
      reset_n => pio_3_s1_reset_n,
      write_n => pio_3_s1_write_n,
      writedata => pio_3_s1_writedata
    );


  --the_pio_4_s1, which is an e_instance
  the_pio_4_s1 : pio_4_s1_arbitrator
    port map(
      cpu_0_data_master_granted_pio_4_s1 => cpu_0_data_master_granted_pio_4_s1,
      cpu_0_data_master_qualified_request_pio_4_s1 => cpu_0_data_master_qualified_request_pio_4_s1,
      cpu_0_data_master_read_data_valid_pio_4_s1 => cpu_0_data_master_read_data_valid_pio_4_s1,
      cpu_0_data_master_requests_pio_4_s1 => cpu_0_data_master_requests_pio_4_s1,
      d1_pio_4_s1_end_xfer => d1_pio_4_s1_end_xfer,
      pio_4_s1_address => pio_4_s1_address,
      pio_4_s1_chipselect => pio_4_s1_chipselect,
      pio_4_s1_readdata_from_sa => pio_4_s1_readdata_from_sa,
      pio_4_s1_reset_n => pio_4_s1_reset_n,
      pio_4_s1_write_n => pio_4_s1_write_n,
      pio_4_s1_writedata => pio_4_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      pio_4_s1_readdata => pio_4_s1_readdata,
      reset_n => clk_0_reset_n
    );


  --the_pio_4, which is an e_ptf_instance
  the_pio_4 : pio_4
    port map(
      out_port => internal_out_port_from_the_pio_4,
      readdata => pio_4_s1_readdata,
      address => pio_4_s1_address,
      chipselect => pio_4_s1_chipselect,
      clk => clk_0,
      reset_n => pio_4_s1_reset_n,
      write_n => pio_4_s1_write_n,
      writedata => pio_4_s1_writedata
    );


  --the_sdram_0_s1, which is an e_instance
  the_sdram_0_s1 : sdram_0_s1_arbitrator
    port map(
      cpu_0_data_master_byteenable_sdram_0_s1 => cpu_0_data_master_byteenable_sdram_0_s1,
      cpu_0_data_master_granted_sdram_0_s1 => cpu_0_data_master_granted_sdram_0_s1,
      cpu_0_data_master_qualified_request_sdram_0_s1 => cpu_0_data_master_qualified_request_sdram_0_s1,
      cpu_0_data_master_read_data_valid_sdram_0_s1 => cpu_0_data_master_read_data_valid_sdram_0_s1,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_requests_sdram_0_s1 => cpu_0_data_master_requests_sdram_0_s1,
      cpu_0_instruction_master_granted_sdram_0_s1 => cpu_0_instruction_master_granted_sdram_0_s1,
      cpu_0_instruction_master_qualified_request_sdram_0_s1 => cpu_0_instruction_master_qualified_request_sdram_0_s1,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1 => cpu_0_instruction_master_read_data_valid_sdram_0_s1,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_instruction_master_requests_sdram_0_s1 => cpu_0_instruction_master_requests_sdram_0_s1,
      d1_sdram_0_s1_end_xfer => d1_sdram_0_s1_end_xfer,
      sdram_0_s1_address => sdram_0_s1_address,
      sdram_0_s1_byteenable_n => sdram_0_s1_byteenable_n,
      sdram_0_s1_chipselect => sdram_0_s1_chipselect,
      sdram_0_s1_read_n => sdram_0_s1_read_n,
      sdram_0_s1_readdata_from_sa => sdram_0_s1_readdata_from_sa,
      sdram_0_s1_reset_n => sdram_0_s1_reset_n,
      sdram_0_s1_waitrequest_from_sa => sdram_0_s1_waitrequest_from_sa,
      sdram_0_s1_write_n => sdram_0_s1_write_n,
      sdram_0_s1_writedata => sdram_0_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_dbs_address => cpu_0_data_master_dbs_address,
      cpu_0_data_master_dbs_write_16 => cpu_0_data_master_dbs_write_16,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_dbs_address => cpu_0_instruction_master_dbs_address,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      reset_n => clk_0_reset_n,
      sdram_0_s1_readdata => sdram_0_s1_readdata,
      sdram_0_s1_readdatavalid => sdram_0_s1_readdatavalid,
      sdram_0_s1_waitrequest => sdram_0_s1_waitrequest
    );


  --the_sdram_0, which is an e_ptf_instance
  the_sdram_0 : sdram_0
    port map(
      za_data => sdram_0_s1_readdata,
      za_valid => sdram_0_s1_readdatavalid,
      za_waitrequest => sdram_0_s1_waitrequest,
      zs_addr => internal_zs_addr_from_the_sdram_0,
      zs_ba => internal_zs_ba_from_the_sdram_0,
      zs_cas_n => internal_zs_cas_n_from_the_sdram_0,
      zs_cke => internal_zs_cke_from_the_sdram_0,
      zs_cs_n => internal_zs_cs_n_from_the_sdram_0,
      zs_dq => zs_dq_to_and_from_the_sdram_0,
      zs_dqm => internal_zs_dqm_from_the_sdram_0,
      zs_ras_n => internal_zs_ras_n_from_the_sdram_0,
      zs_we_n => internal_zs_we_n_from_the_sdram_0,
      az_addr => sdram_0_s1_address,
      az_be_n => sdram_0_s1_byteenable_n,
      az_cs => sdram_0_s1_chipselect,
      az_data => sdram_0_s1_writedata,
      az_rd_n => sdram_0_s1_read_n,
      az_wr_n => sdram_0_s1_write_n,
      clk => clk_0,
      reset_n => sdram_0_s1_reset_n
    );


  --the_sysid_0_control_slave, which is an e_instance
  the_sysid_0_control_slave : sysid_0_control_slave_arbitrator
    port map(
      cpu_0_data_master_granted_sysid_0_control_slave => cpu_0_data_master_granted_sysid_0_control_slave,
      cpu_0_data_master_qualified_request_sysid_0_control_slave => cpu_0_data_master_qualified_request_sysid_0_control_slave,
      cpu_0_data_master_read_data_valid_sysid_0_control_slave => cpu_0_data_master_read_data_valid_sysid_0_control_slave,
      cpu_0_data_master_requests_sysid_0_control_slave => cpu_0_data_master_requests_sysid_0_control_slave,
      d1_sysid_0_control_slave_end_xfer => d1_sysid_0_control_slave_end_xfer,
      sysid_0_control_slave_address => sysid_0_control_slave_address,
      sysid_0_control_slave_readdata_from_sa => sysid_0_control_slave_readdata_from_sa,
      sysid_0_control_slave_reset_n => sysid_0_control_slave_reset_n,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      reset_n => clk_0_reset_n,
      sysid_0_control_slave_readdata => sysid_0_control_slave_readdata
    );


  --the_sysid_0, which is an e_ptf_instance
  the_sysid_0 : sysid_0
    port map(
      readdata => sysid_0_control_slave_readdata,
      address => sysid_0_control_slave_address,
      clock => sysid_0_control_slave_clock,
      reset_n => sysid_0_control_slave_reset_n
    );


  --the_timer_0_s1, which is an e_instance
  the_timer_0_s1 : timer_0_s1_arbitrator
    port map(
      cpu_0_data_master_granted_timer_0_s1 => cpu_0_data_master_granted_timer_0_s1,
      cpu_0_data_master_qualified_request_timer_0_s1 => cpu_0_data_master_qualified_request_timer_0_s1,
      cpu_0_data_master_read_data_valid_timer_0_s1 => cpu_0_data_master_read_data_valid_timer_0_s1,
      cpu_0_data_master_requests_timer_0_s1 => cpu_0_data_master_requests_timer_0_s1,
      d1_timer_0_s1_end_xfer => d1_timer_0_s1_end_xfer,
      timer_0_s1_address => timer_0_s1_address,
      timer_0_s1_chipselect => timer_0_s1_chipselect,
      timer_0_s1_irq_from_sa => timer_0_s1_irq_from_sa,
      timer_0_s1_readdata_from_sa => timer_0_s1_readdata_from_sa,
      timer_0_s1_reset_n => timer_0_s1_reset_n,
      timer_0_s1_write_n => timer_0_s1_write_n,
      timer_0_s1_writedata => timer_0_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n,
      timer_0_s1_irq => timer_0_s1_irq,
      timer_0_s1_readdata => timer_0_s1_readdata
    );


  --the_timer_0, which is an e_ptf_instance
  the_timer_0 : timer_0
    port map(
      irq => timer_0_s1_irq,
      readdata => timer_0_s1_readdata,
      address => timer_0_s1_address,
      chipselect => timer_0_s1_chipselect,
      clk => clk_0,
      reset_n => timer_0_s1_reset_n,
      write_n => timer_0_s1_write_n,
      writedata => timer_0_s1_writedata
    );


  --the_tri_state_bridge_0_avalon_slave, which is an e_instance
  the_tri_state_bridge_0_avalon_slave : tri_state_bridge_0_avalon_slave_arbitrator
    port map(
      address_to_the_cfi_flash_0 => internal_address_to_the_cfi_flash_0,
      cfi_flash_0_s1_wait_counter_eq_0 => cfi_flash_0_s1_wait_counter_eq_0,
      cpu_0_data_master_byteenable_cfi_flash_0_s1 => cpu_0_data_master_byteenable_cfi_flash_0_s1,
      cpu_0_data_master_granted_cfi_flash_0_s1 => cpu_0_data_master_granted_cfi_flash_0_s1,
      cpu_0_data_master_qualified_request_cfi_flash_0_s1 => cpu_0_data_master_qualified_request_cfi_flash_0_s1,
      cpu_0_data_master_read_data_valid_cfi_flash_0_s1 => cpu_0_data_master_read_data_valid_cfi_flash_0_s1,
      cpu_0_data_master_requests_cfi_flash_0_s1 => cpu_0_data_master_requests_cfi_flash_0_s1,
      cpu_0_instruction_master_granted_cfi_flash_0_s1 => cpu_0_instruction_master_granted_cfi_flash_0_s1,
      cpu_0_instruction_master_qualified_request_cfi_flash_0_s1 => cpu_0_instruction_master_qualified_request_cfi_flash_0_s1,
      cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1 => cpu_0_instruction_master_read_data_valid_cfi_flash_0_s1,
      cpu_0_instruction_master_requests_cfi_flash_0_s1 => cpu_0_instruction_master_requests_cfi_flash_0_s1,
      d1_tri_state_bridge_0_avalon_slave_end_xfer => d1_tri_state_bridge_0_avalon_slave_end_xfer,
      data_to_and_from_the_cfi_flash_0 => data_to_and_from_the_cfi_flash_0,
      incoming_data_to_and_from_the_cfi_flash_0 => incoming_data_to_and_from_the_cfi_flash_0,
      incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0 => incoming_data_to_and_from_the_cfi_flash_0_with_Xs_converted_to_0,
      read_n_to_the_cfi_flash_0 => internal_read_n_to_the_cfi_flash_0,
      select_n_to_the_cfi_flash_0 => internal_select_n_to_the_cfi_flash_0,
      write_n_to_the_cfi_flash_0 => internal_write_n_to_the_cfi_flash_0,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_dbs_address => cpu_0_data_master_dbs_address,
      cpu_0_data_master_dbs_write_8 => cpu_0_data_master_dbs_write_8,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_dbs_address => cpu_0_instruction_master_dbs_address,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      reset_n => clk_0_reset_n
    );


  --the_wr_s1, which is an e_instance
  the_wr_s1 : wr_s1_arbitrator
    port map(
      cpu_0_data_master_granted_wr_s1 => cpu_0_data_master_granted_wr_s1,
      cpu_0_data_master_qualified_request_wr_s1 => cpu_0_data_master_qualified_request_wr_s1,
      cpu_0_data_master_read_data_valid_wr_s1 => cpu_0_data_master_read_data_valid_wr_s1,
      cpu_0_data_master_requests_wr_s1 => cpu_0_data_master_requests_wr_s1,
      d1_wr_s1_end_xfer => d1_wr_s1_end_xfer,
      wr_s1_address => wr_s1_address,
      wr_s1_chipselect => wr_s1_chipselect,
      wr_s1_readdata_from_sa => wr_s1_readdata_from_sa,
      wr_s1_reset_n => wr_s1_reset_n,
      wr_s1_write_n => wr_s1_write_n,
      wr_s1_writedata => wr_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n,
      wr_s1_readdata => wr_s1_readdata
    );


  --the_wr, which is an e_ptf_instance
  the_wr : wr
    port map(
      out_port => internal_out_port_from_the_wr,
      readdata => wr_s1_readdata,
      address => wr_s1_address,
      chipselect => wr_s1_chipselect,
      clk => clk_0,
      reset_n => wr_s1_reset_n,
      write_n => wr_s1_write_n,
      writedata => wr_s1_writedata
    );


  --the_wr2_s1, which is an e_instance
  the_wr2_s1 : wr2_s1_arbitrator
    port map(
      cpu_0_data_master_granted_wr2_s1 => cpu_0_data_master_granted_wr2_s1,
      cpu_0_data_master_qualified_request_wr2_s1 => cpu_0_data_master_qualified_request_wr2_s1,
      cpu_0_data_master_read_data_valid_wr2_s1 => cpu_0_data_master_read_data_valid_wr2_s1,
      cpu_0_data_master_requests_wr2_s1 => cpu_0_data_master_requests_wr2_s1,
      d1_wr2_s1_end_xfer => d1_wr2_s1_end_xfer,
      wr2_s1_address => wr2_s1_address,
      wr2_s1_chipselect => wr2_s1_chipselect,
      wr2_s1_readdata_from_sa => wr2_s1_readdata_from_sa,
      wr2_s1_reset_n => wr2_s1_reset_n,
      wr2_s1_write_n => wr2_s1_write_n,
      wr2_s1_writedata => wr2_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n,
      wr2_s1_readdata => wr2_s1_readdata
    );


  --the_wr2, which is an e_ptf_instance
  the_wr2 : wr2
    port map(
      out_port => internal_out_port_from_the_wr2,
      readdata => wr2_s1_readdata,
      address => wr2_s1_address,
      chipselect => wr2_s1_chipselect,
      clk => clk_0,
      reset_n => wr2_s1_reset_n,
      write_n => wr2_s1_write_n,
      writedata => wr2_s1_writedata
    );


  --the_wr3_s1, which is an e_instance
  the_wr3_s1 : wr3_s1_arbitrator
    port map(
      cpu_0_data_master_granted_wr3_s1 => cpu_0_data_master_granted_wr3_s1,
      cpu_0_data_master_qualified_request_wr3_s1 => cpu_0_data_master_qualified_request_wr3_s1,
      cpu_0_data_master_read_data_valid_wr3_s1 => cpu_0_data_master_read_data_valid_wr3_s1,
      cpu_0_data_master_requests_wr3_s1 => cpu_0_data_master_requests_wr3_s1,
      d1_wr3_s1_end_xfer => d1_wr3_s1_end_xfer,
      wr3_s1_address => wr3_s1_address,
      wr3_s1_chipselect => wr3_s1_chipselect,
      wr3_s1_readdata_from_sa => wr3_s1_readdata_from_sa,
      wr3_s1_reset_n => wr3_s1_reset_n,
      wr3_s1_write_n => wr3_s1_write_n,
      wr3_s1_writedata => wr3_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n,
      wr3_s1_readdata => wr3_s1_readdata
    );


  --the_wr3, which is an e_ptf_instance
  the_wr3 : wr3
    port map(
      out_port => internal_out_port_from_the_wr3,
      readdata => wr3_s1_readdata,
      address => wr3_s1_address,
      chipselect => wr3_s1_chipselect,
      clk => clk_0,
      reset_n => wr3_s1_reset_n,
      write_n => wr3_s1_write_n,
      writedata => wr3_s1_writedata
    );


  --the_wr4_s1, which is an e_instance
  the_wr4_s1 : wr4_s1_arbitrator
    port map(
      cpu_0_data_master_granted_wr4_s1 => cpu_0_data_master_granted_wr4_s1,
      cpu_0_data_master_qualified_request_wr4_s1 => cpu_0_data_master_qualified_request_wr4_s1,
      cpu_0_data_master_read_data_valid_wr4_s1 => cpu_0_data_master_read_data_valid_wr4_s1,
      cpu_0_data_master_requests_wr4_s1 => cpu_0_data_master_requests_wr4_s1,
      d1_wr4_s1_end_xfer => d1_wr4_s1_end_xfer,
      wr4_s1_address => wr4_s1_address,
      wr4_s1_chipselect => wr4_s1_chipselect,
      wr4_s1_readdata_from_sa => wr4_s1_readdata_from_sa,
      wr4_s1_reset_n => wr4_s1_reset_n,
      wr4_s1_write_n => wr4_s1_write_n,
      wr4_s1_writedata => wr4_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      reset_n => clk_0_reset_n,
      wr4_s1_readdata => wr4_s1_readdata
    );


  --the_wr4, which is an e_ptf_instance
  the_wr4 : wr4
    port map(
      out_port => internal_out_port_from_the_wr4,
      readdata => wr4_s1_readdata,
      address => wr4_s1_address,
      chipselect => wr4_s1_chipselect,
      clk => clk_0,
      reset_n => wr4_s1_reset_n,
      write_n => wr4_s1_write_n,
      writedata => wr4_s1_writedata
    );


  --reset is asserted asynchronously and deasserted synchronously
  nios2_reset_clk_0_domain_synch : nios2_reset_clk_0_domain_synch_module
    port map(
      data_out => clk_0_reset_n,
      clk => clk_0,
      data_in => module_input6,
      reset_n => reset_n_sources
    );

  module_input6 <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_jtag_debug_module_resetrequest_from_sa))))));
  --sysid_0_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  sysid_0_control_slave_clock <= std_logic'('0');
  --vhdl renameroo for output signals
  address_to_the_cfi_flash_0 <= internal_address_to_the_cfi_flash_0;
  --vhdl renameroo for output signals
  dclk_from_the_epcs_flash_controller_0 <= internal_dclk_from_the_epcs_flash_controller_0;
  --vhdl renameroo for output signals
  out_port_from_the_addr <= internal_out_port_from_the_addr;
  --vhdl renameroo for output signals
  out_port_from_the_addr2 <= internal_out_port_from_the_addr2;
  --vhdl renameroo for output signals
  out_port_from_the_addr3 <= internal_out_port_from_the_addr3;
  --vhdl renameroo for output signals
  out_port_from_the_addr4 <= internal_out_port_from_the_addr4;
  --vhdl renameroo for output signals
  out_port_from_the_pio_1 <= internal_out_port_from_the_pio_1;
  --vhdl renameroo for output signals
  out_port_from_the_pio_2 <= internal_out_port_from_the_pio_2;
  --vhdl renameroo for output signals
  out_port_from_the_pio_3 <= internal_out_port_from_the_pio_3;
  --vhdl renameroo for output signals
  out_port_from_the_pio_4 <= internal_out_port_from_the_pio_4;
  --vhdl renameroo for output signals
  out_port_from_the_wr <= internal_out_port_from_the_wr;
  --vhdl renameroo for output signals
  out_port_from_the_wr2 <= internal_out_port_from_the_wr2;
  --vhdl renameroo for output signals
  out_port_from_the_wr3 <= internal_out_port_from_the_wr3;
  --vhdl renameroo for output signals
  out_port_from_the_wr4 <= internal_out_port_from_the_wr4;
  --vhdl renameroo for output signals
  read_n_to_the_cfi_flash_0 <= internal_read_n_to_the_cfi_flash_0;
  --vhdl renameroo for output signals
  sce_from_the_epcs_flash_controller_0 <= internal_sce_from_the_epcs_flash_controller_0;
  --vhdl renameroo for output signals
  sdo_from_the_epcs_flash_controller_0 <= internal_sdo_from_the_epcs_flash_controller_0;
  --vhdl renameroo for output signals
  select_n_to_the_cfi_flash_0 <= internal_select_n_to_the_cfi_flash_0;
  --vhdl renameroo for output signals
  txd_from_the_HC_12 <= internal_txd_from_the_HC_12;
  --vhdl renameroo for output signals
  txd_from_the_US_100_UART <= internal_txd_from_the_US_100_UART;
  --vhdl renameroo for output signals
  write_n_to_the_cfi_flash_0 <= internal_write_n_to_the_cfi_flash_0;
  --vhdl renameroo for output signals
  zs_addr_from_the_sdram_0 <= internal_zs_addr_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_ba_from_the_sdram_0 <= internal_zs_ba_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_cas_n_from_the_sdram_0 <= internal_zs_cas_n_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_cke_from_the_sdram_0 <= internal_zs_cke_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_cs_n_from_the_sdram_0 <= internal_zs_cs_n_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_dqm_from_the_sdram_0 <= internal_zs_dqm_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_ras_n_from_the_sdram_0 <= internal_zs_ras_n_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_we_n_from_the_sdram_0 <= internal_zs_we_n_from_the_sdram_0;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cfi_flash_0_lane0_module is 
        port (
              -- inputs:
                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal rdclken : IN STD_LOGIC;
                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal wrclock : IN STD_LOGIC;
                 signal wren : IN STD_LOGIC;

              -- outputs:
                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity cfi_flash_0_lane0_module;


architecture europa of cfi_flash_0_lane0_module is
              signal internal_q :  STD_LOGIC_VECTOR (7 DOWNTO 0);
              TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
              signal memory_has_been_read :  STD_LOGIC;
              signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);

      
FUNCTION convert_string_to_number(string_to_convert : STRING;
      final_char_index : NATURAL := 0)
RETURN NATURAL IS
   VARIABLE result: NATURAL := 0;
   VARIABLE current_index : NATURAL := 1;
   VARIABLE the_char : CHARACTER;

   BEGIN
      IF final_char_index = 0 THEN
         result := 0;
	 ELSE
         WHILE current_index <= final_char_index LOOP
            the_char := string_to_convert(current_index);
            IF    '0' <= the_char AND the_char <= '9' THEN
               result := result * 16 + character'pos(the_char) - character'pos('0');
            ELSIF 'A' <= the_char AND the_char <= 'F' THEN
               result := result * 16 + character'pos(the_char) - character'pos('A') + 10;
            ELSIF 'a' <= the_char AND the_char <= 'f' THEN
               result := result * 16 + character'pos(the_char) - character'pos('a') + 10;
            ELSE
               report "Ack, a formatting error!";
            END IF;
            current_index := current_index + 1;
         END LOOP;
      END IF; 
   RETURN result;
END convert_string_to_number;

 FUNCTION convert_string_to_std_logic(value : STRING; num_chars : INTEGER; mem_width_bits : INTEGER)
 RETURN STD_LOGIC_VECTOR is			   
     VARIABLE conv_string: std_logic_vector((mem_width_bits + 4)-1 downto 0);
     VARIABLE result : std_logic_vector((mem_width_bits -1) downto 0);
     VARIABLE curr_char : integer;
              
     BEGIN
     result := (others => '0');
     conv_string := (others => '0');
     
          FOR I IN 1 TO num_chars LOOP
	     curr_char := num_chars - (I-1);

             CASE value(I) IS
               WHEN '0' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0000";
               WHEN '1' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0001";
               WHEN '2' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0010";
               WHEN '3' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0011";
               WHEN '4' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0100";
               WHEN '5' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0101";
               WHEN '6' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0110";
               WHEN '7' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0111";
               WHEN '8' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1000";
               WHEN '9' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1001";
               WHEN 'A' | 'a' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1010";
               WHEN 'B' | 'b' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1011";
               WHEN 'C' | 'c' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1100";
               WHEN 'D' | 'd' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1101";
               WHEN 'E' | 'e' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1110";
               WHEN 'F' | 'f' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1111";
               WHEN 'X' | 'x' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "XXXX";
               WHEN ' ' => EXIT;
               WHEN HT  => exit;
               WHEN others =>
                  ASSERT False
                  REPORT "function From_Hex: string """ & value & """ contains non-hex character"
                       severity Error;
                  EXIT;
               END case;
            END loop;

          -- convert back to normal bit size
          result(mem_width_bits - 1 downto 0) := conv_string(mem_width_bits - 1 downto 0);

          RETURN result;
        END convert_string_to_std_logic;



begin
   process (wrclock, rdaddress) -- MG
    VARIABLE data_line : LINE;
    VARIABLE the_character_from_data_line : CHARACTER;
    VARIABLE b_munging_address : BOOLEAN := FALSE;
    VARIABLE converted_number : NATURAL := 0;
    VARIABLE found_string_array : STRING(1 TO 128);
    VARIABLE string_index : NATURAL := 0;
    VARIABLE line_length : NATURAL := 0;
    VARIABLE b_convert : BOOLEAN := FALSE;
    VARIABLE b_found_new_val : BOOLEAN := FALSE;
    VARIABLE load_address : NATURAL := 0;
    VARIABLE mem_index : NATURAL := 0;
    VARIABLE mem_init : BOOLEAN := FALSE;

    VARIABLE wr_address_internal : STD_LOGIC_VECTOR (17 DOWNTO 0) := (others => '0');
    FILE memory_contents_file : TEXT OPEN read_mode IS "cfi_flash_0.dat";  
    variable Marc_Gaucherons_Memory_Variable : mem_array; -- MG
    
    begin
   -- need an initialization process
   -- this process initializes the whole memory array from a named file by copying the
   -- contents of the *.dat file to the memory array.

   -- find the @<address> thingy to load the memory from this point 
IF(NOT mem_init) THEN
   WHILE NOT(endfile(memory_contents_file)) LOOP

      readline(memory_contents_file, data_line);
      line_length := data_line'LENGTH;


      WHILE line_length > 0 LOOP
         read(data_line, the_character_from_data_line);

	       -- check for the @ character indicating a new address wad
 	       -- if not found, we're either still reading the new address _or_loading data
         IF '@' = the_character_from_data_line AND NOT b_munging_address THEN
  	    b_munging_address := TRUE;
            b_found_new_val := TRUE; 
	    -- get the rest of characters before white space and then convert them
	    -- to a number
	 ELSE 

            IF (' ' = the_character_from_data_line AND b_found_new_val) 
		OR (line_length = 1) THEN
               b_convert := TRUE;
	    END IF;

            IF NOT(' ' = the_character_from_data_line) THEN
               string_index := string_index + 1;
               found_string_array(string_index) := the_character_from_data_line;
--               IF NOT(b_munging_address) THEN
--                 dat_string_array(string_index) := the_character_from_data_line;
--               END IF;
	       b_found_new_val := TRUE;
            END IF;
	 END IF;

     IF b_convert THEN

       IF b_munging_address THEN
          converted_number := convert_string_to_number(found_string_array, string_index);    
          load_address := converted_number;
          mem_index := load_address;
--          mem_index := load_address / 1;
          b_munging_address := FALSE;
       ELSE
	  IF (mem_index < 262144) THEN
	    Marc_Gaucherons_Memory_Variable(mem_index) := convert_string_to_std_logic(found_string_array, string_index, 8);
            mem_index := mem_index + 1;
          END IF;
       END IF; 
       b_convert := FALSE;
       b_found_new_val := FALSE;
       string_index := 0;
    END IF;
    line_length := line_length - 1; 
    END LOOP;

END LOOP;
-- get the first _real_ block of data, sized to our memory width
-- and keep on loading.
  mem_init := TRUE;
END IF;
-- END OF READMEM



      -- Write data
      if wrclock'event and wrclock = '1' then
        wr_address_internal := wraddress;
        if wren = '1' then 
          Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(wr_address_internal))) := data;
        end if;
      end if;

      -- read data
      q <= Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(rdaddress)));
      


    end process;
end europa;

--synthesis translate_on


--synthesis read_comments_as_HDL on
--library altera;
--use altera.altera_europa_support_lib.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--
--library std;
--use std.textio.all;
--
--entity cfi_flash_0_lane0_module is 
--        port (
--              
--                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal rdclken : IN STD_LOGIC;
--                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal wrclock : IN STD_LOGIC;
--                 signal wren : IN STD_LOGIC;
--
--              
--                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--              );
--end entity cfi_flash_0_lane0_module;
--
--
--architecture europa of cfi_flash_0_lane0_module is
--  component lpm_ram_dp is
--GENERIC (
--      lpm_file : STRING;
--        lpm_hint : STRING;
--        lpm_indata : STRING;
--        lpm_outdata : STRING;
--        lpm_rdaddress_control : STRING;
--        lpm_width : NATURAL;
--        lpm_widthad : NATURAL;
--        lpm_wraddress_control : STRING;
--        suppress_memory_conversion_warnings : STRING
--      );
--    PORT (
--    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal wren : IN STD_LOGIC;
--        signal wrclock : IN STD_LOGIC;
--        signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdclken : IN STD_LOGIC
--      );
--  end component lpm_ram_dp;
--                signal internal_q :  STD_LOGIC_VECTOR (7 DOWNTO 0);
--                TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
--                signal memory_has_been_read :  STD_LOGIC;
--                signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
--
--begin
--
--  process (rdaddress)
--  begin
--      read_address <= rdaddress;
--
--  end process;
--
--  lpm_ram_dp_component : lpm_ram_dp
--    generic map(
--      lpm_file => "cfi_flash_0.mif",
--      lpm_hint => "USE_EAB=ON",
--      lpm_indata => "REGISTERED",
--      lpm_outdata => "UNREGISTERED",
--      lpm_rdaddress_control => "UNREGISTERED",
--      lpm_width => 8,
--      lpm_widthad => 18,
--      lpm_wraddress_control => "REGISTERED",
--      suppress_memory_conversion_warnings => "ON"
--    )
--    port map(
--            data => data,
--            q => internal_q,
--            rdaddress => read_address,
--            rdclken => rdclken,
--            wraddress => wraddress,
--            wrclock => wrclock,
--            wren => wren
--    );
--
--  
--  q <= internal_q;
--end europa;
--
--synthesis read_comments_as_HDL off


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cfi_flash_0 is 
        port (
              -- inputs:
                 signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal read_n : IN STD_LOGIC;
                 signal select_n : IN STD_LOGIC;
                 signal write_n : IN STD_LOGIC;

              -- outputs:
                 signal data : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity cfi_flash_0;


architecture europa of cfi_flash_0 is
--synthesis translate_off
component cfi_flash_0_lane0_module is 
           port (
                 -- inputs:
                    signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal rdclken : IN STD_LOGIC;
                    signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal wrclock : IN STD_LOGIC;
                    signal wren : IN STD_LOGIC;

                 -- outputs:
                    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component cfi_flash_0_lane0_module;

--synthesis translate_on
                signal data_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal logic_vector_gasket :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal module_input7 :  STD_LOGIC;
                signal module_input8 :  STD_LOGIC;
                signal q_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);

begin

  --s1, which is an e_ptf_slave
--synthesis translate_off
    logic_vector_gasket <= data;
    data_0 <= logic_vector_gasket(7 DOWNTO 0);
    --cfi_flash_0_lane0, which is an e_ram
    cfi_flash_0_lane0 : cfi_flash_0_lane0_module
      port map(
        q => q_0,
        data => data_0,
        rdaddress => address,
        rdclken => module_input7,
        wraddress => address,
        wrclock => write_n,
        wren => module_input8
      );

    module_input7 <= std_logic'('1');
    module_input8 <= NOT select_n;

    data <= A_WE_StdLogicVector((std_logic'(((NOT select_n AND NOT read_n))) = '1'), q_0, A_REP(std_logic'('Z'), 8));
--synthesis translate_on

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component nios2 is 
           port (
                 -- 1) global signals:
                    signal clk_0 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_HC_12
                    signal rxd_to_the_HC_12 : IN STD_LOGIC;
                    signal txd_from_the_HC_12 : OUT STD_LOGIC;

                 -- the_US_100_UART
                    signal rxd_to_the_US_100_UART : IN STD_LOGIC;
                    signal txd_from_the_US_100_UART : OUT STD_LOGIC;

                 -- the_addr
                    signal out_port_from_the_addr : OUT STD_LOGIC;

                 -- the_addr2
                    signal out_port_from_the_addr2 : OUT STD_LOGIC;

                 -- the_addr3
                    signal out_port_from_the_addr3 : OUT STD_LOGIC;

                 -- the_addr4
                    signal out_port_from_the_addr4 : OUT STD_LOGIC;

                 -- the_epcs_flash_controller_0
                    signal data0_to_the_epcs_flash_controller_0 : IN STD_LOGIC;
                    signal dclk_from_the_epcs_flash_controller_0 : OUT STD_LOGIC;
                    signal sce_from_the_epcs_flash_controller_0 : OUT STD_LOGIC;
                    signal sdo_from_the_epcs_flash_controller_0 : OUT STD_LOGIC;

                 -- the_opencores_i2c_fbm320
                    signal scl_pad_io_to_and_from_the_opencores_i2c_fbm320 : INOUT STD_LOGIC;
                    signal sda_pad_io_to_and_from_the_opencores_i2c_fbm320 : INOUT STD_LOGIC;

                 -- the_opencores_i2c_jy901
                    signal scl_pad_io_to_and_from_the_opencores_i2c_jy901 : INOUT STD_LOGIC;
                    signal sda_pad_io_to_and_from_the_opencores_i2c_jy901 : INOUT STD_LOGIC;

                 -- the_pio_0
                    signal in_port_to_the_pio_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

                 -- the_pio_1
                    signal out_port_from_the_pio_1 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

                 -- the_pio_2
                    signal out_port_from_the_pio_2 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

                 -- the_pio_3
                    signal out_port_from_the_pio_3 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

                 -- the_pio_4
                    signal out_port_from_the_pio_4 : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);

                 -- the_sdram_0
                    signal zs_addr_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                    signal zs_ba_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_cke_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_cs_n_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_dq_to_and_from_the_sdram_0 : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_we_n_from_the_sdram_0 : OUT STD_LOGIC;

                 -- the_tri_state_bridge_0_avalon_slave
                    signal address_to_the_cfi_flash_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal data_to_and_from_the_cfi_flash_0 : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal read_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                    signal select_n_to_the_cfi_flash_0 : OUT STD_LOGIC;
                    signal write_n_to_the_cfi_flash_0 : OUT STD_LOGIC;

                 -- the_wr
                    signal out_port_from_the_wr : OUT STD_LOGIC;

                 -- the_wr2
                    signal out_port_from_the_wr2 : OUT STD_LOGIC;

                 -- the_wr3
                    signal out_port_from_the_wr3 : OUT STD_LOGIC;

                 -- the_wr4
                    signal out_port_from_the_wr4 : OUT STD_LOGIC
                 );
end component nios2;

component cfi_flash_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal read_n : IN STD_LOGIC;
                    signal select_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;

                 -- outputs:
                    signal data : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component cfi_flash_0;

                signal HC_12_s1_dataavailable_from_sa :  STD_LOGIC;
                signal HC_12_s1_readyfordata_from_sa :  STD_LOGIC;
                signal US_100_UART_s1_dataavailable_from_sa :  STD_LOGIC;
                signal US_100_UART_s1_readyfordata_from_sa :  STD_LOGIC;
                signal address_to_the_cfi_flash_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal clk :  STD_LOGIC;
                signal clk_0 :  STD_LOGIC;
                signal data0_to_the_epcs_flash_controller_0 :  STD_LOGIC;
                signal data_to_and_from_the_cfi_flash_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dclk_from_the_epcs_flash_controller_0 :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal in_port_to_the_pio_0 :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal out_port_from_the_addr :  STD_LOGIC;
                signal out_port_from_the_addr2 :  STD_LOGIC;
                signal out_port_from_the_addr3 :  STD_LOGIC;
                signal out_port_from_the_addr4 :  STD_LOGIC;
                signal out_port_from_the_pio_1 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal out_port_from_the_pio_2 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal out_port_from_the_pio_3 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal out_port_from_the_pio_4 :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal out_port_from_the_wr :  STD_LOGIC;
                signal out_port_from_the_wr2 :  STD_LOGIC;
                signal out_port_from_the_wr3 :  STD_LOGIC;
                signal out_port_from_the_wr4 :  STD_LOGIC;
                signal read_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal reset_n :  STD_LOGIC;
                signal rxd_to_the_HC_12 :  STD_LOGIC;
                signal rxd_to_the_US_100_UART :  STD_LOGIC;
                signal sce_from_the_epcs_flash_controller_0 :  STD_LOGIC;
                signal scl_pad_io_to_and_from_the_opencores_i2c_fbm320 :  STD_LOGIC;
                signal scl_pad_io_to_and_from_the_opencores_i2c_jy901 :  STD_LOGIC;
                signal sda_pad_io_to_and_from_the_opencores_i2c_fbm320 :  STD_LOGIC;
                signal sda_pad_io_to_and_from_the_opencores_i2c_jy901 :  STD_LOGIC;
                signal sdo_from_the_epcs_flash_controller_0 :  STD_LOGIC;
                signal select_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal sysid_0_control_slave_clock :  STD_LOGIC;
                signal txd_from_the_HC_12 :  STD_LOGIC;
                signal txd_from_the_US_100_UART :  STD_LOGIC;
                signal write_n_to_the_cfi_flash_0 :  STD_LOGIC;
                signal zs_addr_from_the_sdram_0 :  STD_LOGIC_VECTOR (12 DOWNTO 0);
                signal zs_ba_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_cas_n_from_the_sdram_0 :  STD_LOGIC;
                signal zs_cke_from_the_sdram_0 :  STD_LOGIC;
                signal zs_cs_n_from_the_sdram_0 :  STD_LOGIC;
                signal zs_dq_to_and_from_the_sdram_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal zs_dqm_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_ras_n_from_the_sdram_0 :  STD_LOGIC;
                signal zs_we_n_from_the_sdram_0 :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : nios2
    port map(
      address_to_the_cfi_flash_0 => address_to_the_cfi_flash_0,
      data_to_and_from_the_cfi_flash_0 => data_to_and_from_the_cfi_flash_0,
      dclk_from_the_epcs_flash_controller_0 => dclk_from_the_epcs_flash_controller_0,
      out_port_from_the_addr => out_port_from_the_addr,
      out_port_from_the_addr2 => out_port_from_the_addr2,
      out_port_from_the_addr3 => out_port_from_the_addr3,
      out_port_from_the_addr4 => out_port_from_the_addr4,
      out_port_from_the_pio_1 => out_port_from_the_pio_1,
      out_port_from_the_pio_2 => out_port_from_the_pio_2,
      out_port_from_the_pio_3 => out_port_from_the_pio_3,
      out_port_from_the_pio_4 => out_port_from_the_pio_4,
      out_port_from_the_wr => out_port_from_the_wr,
      out_port_from_the_wr2 => out_port_from_the_wr2,
      out_port_from_the_wr3 => out_port_from_the_wr3,
      out_port_from_the_wr4 => out_port_from_the_wr4,
      read_n_to_the_cfi_flash_0 => read_n_to_the_cfi_flash_0,
      sce_from_the_epcs_flash_controller_0 => sce_from_the_epcs_flash_controller_0,
      scl_pad_io_to_and_from_the_opencores_i2c_fbm320 => scl_pad_io_to_and_from_the_opencores_i2c_fbm320,
      scl_pad_io_to_and_from_the_opencores_i2c_jy901 => scl_pad_io_to_and_from_the_opencores_i2c_jy901,
      sda_pad_io_to_and_from_the_opencores_i2c_fbm320 => sda_pad_io_to_and_from_the_opencores_i2c_fbm320,
      sda_pad_io_to_and_from_the_opencores_i2c_jy901 => sda_pad_io_to_and_from_the_opencores_i2c_jy901,
      sdo_from_the_epcs_flash_controller_0 => sdo_from_the_epcs_flash_controller_0,
      select_n_to_the_cfi_flash_0 => select_n_to_the_cfi_flash_0,
      txd_from_the_HC_12 => txd_from_the_HC_12,
      txd_from_the_US_100_UART => txd_from_the_US_100_UART,
      write_n_to_the_cfi_flash_0 => write_n_to_the_cfi_flash_0,
      zs_addr_from_the_sdram_0 => zs_addr_from_the_sdram_0,
      zs_ba_from_the_sdram_0 => zs_ba_from_the_sdram_0,
      zs_cas_n_from_the_sdram_0 => zs_cas_n_from_the_sdram_0,
      zs_cke_from_the_sdram_0 => zs_cke_from_the_sdram_0,
      zs_cs_n_from_the_sdram_0 => zs_cs_n_from_the_sdram_0,
      zs_dq_to_and_from_the_sdram_0 => zs_dq_to_and_from_the_sdram_0,
      zs_dqm_from_the_sdram_0 => zs_dqm_from_the_sdram_0,
      zs_ras_n_from_the_sdram_0 => zs_ras_n_from_the_sdram_0,
      zs_we_n_from_the_sdram_0 => zs_we_n_from_the_sdram_0,
      clk_0 => clk_0,
      data0_to_the_epcs_flash_controller_0 => data0_to_the_epcs_flash_controller_0,
      in_port_to_the_pio_0 => in_port_to_the_pio_0,
      reset_n => reset_n,
      rxd_to_the_HC_12 => rxd_to_the_HC_12,
      rxd_to_the_US_100_UART => rxd_to_the_US_100_UART
    );


  --the_cfi_flash_0, which is an e_ptf_instance
  the_cfi_flash_0 : cfi_flash_0
    port map(
      data => data_to_and_from_the_cfi_flash_0,
      address => address_to_the_cfi_flash_0,
      read_n => read_n_to_the_cfi_flash_0,
      select_n => select_n_to_the_cfi_flash_0,
      write_n => write_n_to_the_cfi_flash_0
    );


  process
  begin
    clk_0 <= '0';
    loop
       wait for 10 ns;
       clk_0 <= not clk_0;
    end loop;
  end process;
  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 200 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
