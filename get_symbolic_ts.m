function [sysymbolic_ts]=get_symbolic_ts(ts,number)
[M,N]=size(ts);
sysymbolic_ts=[];
max_val=max(ts);
min_val=min(ts);
step=(max_val-min_val)/number;
for i=1:M
    sysymbolic_ts(i)=floor((ts(i)-min_val)/step);
end
