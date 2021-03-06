//自定义PWM组件设计

//pwm.v

module pwm(

        clk,     //clk
		   addr,    //address
        wr_n,    //write_n   
       
        i_data,  //writedata
        o_pwm    //export
       );

    input  clk,wr_n,addr;
    output  o_pwm;
    input  [19:0]  i_data;//7
	 
    reg [19:0] period,duty,counter;//周期、占空比、计数器//7
	 wire	 o_pwm;

   always@(posedge clk)
       begin
          if(!wr_n) //wr_n为低，写数据
             begin
               if(!addr)  //addr为低，改变周期
                begin  
                  period<=i_data;
                  duty<=duty;
                end
               else       //addr为高，改变占空比
                begin
                  period<=period;
                  duty<=i_data;
                end
             end
          else//wr_n为高，周期和占空比保持
             begin
                  period<=period;
                  duty<=duty;
             end
      end

  always@(posedge clk)
       begin
         if(!counter)   //计数器为0，重置为周期

            counter<=period;
         else           //计数器不为0，则自减
            counter<=counter-1;
       end

  assign o_pwm=((counter<duty)?0:1); //计数器值>占空比 输出0；反之，输出1

endmodule
           