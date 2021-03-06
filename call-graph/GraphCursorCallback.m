function output_txt = GraphCursorCallback(obj, event_obj, NodeProperties)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text (character vector or cell array of character vectors).

     global G;
     global nodeSize;
     global nodeNeighbourSize;
     global nodeSelectedSize;
     
     h = event_obj.Target;
     pos = get(event_obj,'Position');
     ind = find(h.XData == pos(1) & h.YData == pos(2), 1);
     
     % Reset color & size  
     h.NodeColor = [1 0 0];
     h.NodeLabel = [];
     h.MarkerSize = nodeSize;
     
     % Set color & size of selected node
     highlight(h, ind, 'NodeColor', "g", "MarkerSize", nodeSelectedSize);
     
     % Find predecessors of node
      pre = predecessors(G, ind);
      for i = 1 : size(pre, 1)
           highlight(h, pre(i), 'NodeColor', "y", "MarkerSize", nodeNeighbourSize);
           labelnode(h, pre(i), G.Nodes.Name(pre(i)));
      end
     
     % Find successors of node
      succ = successors(G, ind);
      for i = 1 : size(succ, 1)
           highlight(h, succ(i), 'NodeColor', "b", "MarkerSize", nodeNeighbourSize);
           labelnode(h, succ(i), G.Nodes.Name(succ(i)));
      end

    output_txt = [G.Nodes.Name(ind)
                  'Number of incoming calls: ' num2str(size(pre, 1))
                  'Number of outgoing calls: ' num2str(size(succ, 1))];


end

