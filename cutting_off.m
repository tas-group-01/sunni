function I_out =  cutting_off(I_in)
%% function that cuts the captured number for better classification

I_out = I_in;
%vertical cut
for i = 1:5

	if sum(I_out(end,:)) > sum(I_out(1,:))
		I_out = I_out(2:end,:);
	else
		I_out = I_out(1:end-1,:);
	end

end

%horizontal cut
for i = 1:2

	if sum(I_out(:,end)) > sum(I_out(:,1))
		I_out = I_out(:,2:end);
	else
		I_out = I_out(:,1:end-1);
	end

end


end
