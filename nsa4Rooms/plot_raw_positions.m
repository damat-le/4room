function hp=plot_raw_positions(session_positions,col)
% hfig=figure; hold on; box on; grid on;
% hm=size(session_positions,1);
try
    col_=col;
catch
    col_=ones(1,3)*0.7;
end
% hp=plot3(session_positions(:,1),session_positions(:,2),session_positions(:,3),'k.','Color',col_);
hp=plot(session_positions(:,1),session_positions(:,2),'k.','Color',col_);

xlabel('X');
ylabel('Y');
% zlabel('Z');
fs=15;
text(double(min(session_positions(:,1))),double(max(session_positions(:,2))),'A','fontsize',fs);
text(double(max(session_positions(:,1))),double(max(session_positions(:,2))),'B','fontsize',fs);
text(double(max(session_positions(:,1))),double(min(session_positions(:,2))),'C','fontsize',fs);
text(double(min(session_positions(:,1))),double(min(session_positions(:,2))),'D','fontsize',fs);
end