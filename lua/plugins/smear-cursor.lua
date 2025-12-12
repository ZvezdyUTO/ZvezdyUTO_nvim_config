return {
    "sphamba/smear-cursor.nvim",
    opts = {
        stiffness = 0.6, -- 拖尾刚度（0-1，值越大回弹越快）
        trailing_stiffness = 0.5, -- 尾部刚度（0-1）
        distance_stop_animating = 0.5, -- 停止动画的最小距离（>0）
        cursor_color = "#ff8800"
    }
}
