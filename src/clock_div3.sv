
module clk_div3_50 (
  input  logic clk,
  input  logic rst_n,
  output logic clk_div3_50
);

    logic [1:0] pos_cnt;

    logic rise_pulse_reg;

  
  logic neg_pulse_reg;

  always_ff@(posedge clk or negedge rst_n) begin
  if(!rst_n) begin
  pos_cnt<=0;
  end else begin
  if(pos_cnt==2'd2) begin
  pos_cnt<=2'b00; 
  end else 
  pos_cnt<= pos_cnt+1'b1;
  end
  end

  always_ff@(posedge clk or negedge rst_n) begin
  if(!rst_n) begin
    rise_pulse_reg<='0;
  end else begin
  if(pos_cnt==2'd2) begin
  rise_pulse_reg<='1;
  end else 
  rise_pulse_reg<='0;
  end
  end

  always_ff@(negedge clk or negedge rst_n) begin
  if(!rst_n) begin
    neg_pulse_reg<='0;
  end else begin
  if(pos_cnt==2'd2) begin
  neg_pulse_reg<='1;
  end else 
  neg_pulse_reg<='0;
  end
  end

 assign clk_div3_50=(rise_pulse_reg) | (neg_pulse_reg);



//initially used 2 always blocks where both blocks try to change the pos_cnt register which will cause the multiple drivers error
// and leads to confused state added 3 separate always blocks for counting and for the rising edge and falling edge flags
