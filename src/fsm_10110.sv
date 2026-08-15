
module seq_det_10110 (
  input  logic clk,
  input  logic rst_n,
  input  logic bit_in,
  output logic match_pulse
);

typedef enum logic[2:0] {
  a=3'h1,
  b=3'h2,
  c=3'h3,
  d=3'h4,
  e=3'h5
}state_t;

state_t current_state,next_state;

always_ff@(posedge clk or negedge rst_n) begin
if(!rst_n) begin
current_state= a;
end else begin
  current_state<=next_state;
end
end

always_comb begin
next_state=current_state;
case(current_state) 
a: begin
if(bit_in==0) next_state=a;
else next_state=b;
end
b: begin
if(bit_in==0) next_state=c;
else next_state=b;
end
c:begin
  if(bit_in==0) next_state=a;
  else next_state=d;
end
d:begin
if(bit_in==0) next_state=c;
else next_state=e;
end
e:begin
if(bit_in==0) next_state=c;
else next_state=b;
end
default:next_state=a;
endcase
assign match_pulse=(current_state==e)?1:0;
end
endmodule