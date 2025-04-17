function targetGrasped = attachToTool(hitactorname_l, hitactorname_r, detachSignal)
% © Copyright 2025 The MathWorks, Inc.


% W is the handle for the world. With W you can access the handle
% of all the Actors present in the world
persistent actorName localGrasped
if isempty(actorName)
    actorName = "";
end

if isempty(localGrasped)
    localGrasped = 0;
end

W = sim3d.World.getWorld(string(bdroot));

targetGrasped=localGrasped;

if ~isempty(W)
    % For Attaching TargetBox to tool (Gripper)
    % if strcmp(hitactorname_l, "Actor40") || strcmp(hitactorname_r, "Actor40")
    if (hitactorname_l ~= "" || hitactorname_r ~= "") && isempty(fieldnames(W.Actors.left_inner_finger_pad.Children))

        if hitactorname_l ~= ""
            targetactor = W.Root.findBy('ActorName',hitactorname_l);
            actorName = hitactorname_l;
        else
            targetactor = W.Root.findBy('ActorName',hitactorname_r);
            actorName = hitactorname_r;
        end
        % Attaching target Actor which is box here to tool (which is the
        % handle for the gripper actor of the robot

        % Based on different name of the gripper the following function
        % argument needs to be updated
        targetactor{1}.attachTo(W.Actors.left_inner_finger_pad);
        localGrasped = 1;
        targetGrasped = localGrasped;
    end

    % Use For Detaching TargetBox from tool
    % disp(detachsignal);
    if(~detachSignal && ~isempty(fieldnames(W.Actors.left_inner_finger_pad.Children)))
        targetactor = W.Root.findBy('ActorName',actorName);
        targetactor{1}.attachTo(W.Root);
        targetactor{1}.Physics = true;
        targetactor{1}.Gravity = true;
        localGrasped = 0;
        targetGrasped = localGrasped;
    end

end
end

