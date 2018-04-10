//�Զ���PWM������

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
	 
    reg [19:0] period,duty,counter;//���ڡ�ռ�ձȡ�������//7
	 wire	 o_pwm;

   always@(posedge clk)
       begin
          if(!wr_n) //wr_nΪ�ͣ�д����
             begin
               if(!addr)  //addrΪ�ͣ��ı�����
                begin  
                  period<=i_data;
                  duty<=duty;
                end
               else       //addrΪ�ߣ��ı�ռ�ձ�
                begin
                  period<=period;
                  duty<=i_data;
                end
             end
          else//wr_nΪ�ߣ����ں�ռ�ձȱ���
             begin
                  period<=period;
                  duty<=duty;
             end
      end

  always@(posedge clk)
       begin
         if(!counter)   //������Ϊ0������Ϊ����

            counter<=period;
         else           //��������Ϊ0�����Լ�
            counter<=counter-1;
       end

  assign o_pwm=((counter<duty)?0:1); //������ֵ>ռ�ձ� ���0����֮�����1

endmodule
           