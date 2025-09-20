/*
Problem: Tree Node (LeetCode #608)
Link: https://leetcode.com/problems/tree-node
Difficulty: Medium

Description:
Report the type of each node in the tree, which can be 'Leaf', 'Root', or 'Inner'.

Approach:
1. Write CASE WHEN to display the type of the node:
    - if the id's parent_id is null, it is 'Root',
    - if the id does not exist in the parent_id, it is 'Inner',
    - if the id is neither 'Root' or 'Inner', it is 'Leaf'.

Notes / Pitfalls:
- CASE WHEN to classify the records based on multiple conditions.
*/

SELECT id, CASE WHEN p_id IS NULL THEN 'Root'
                WHEN id IN (SELECT DISTINCT p_id FROM Tree) THEN 'Inner'
                ELSE 'Leaf' END AS type
FROM Tree
