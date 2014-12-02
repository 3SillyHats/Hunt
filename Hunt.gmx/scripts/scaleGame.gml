var base_w = 1920;
var base_h = 1080;
var aspect = base_w / base_h ; // get the GAME aspect ratio
if (display_get_width() < display_get_height())
    {
    //portrait
    var ww = min(base_w, display_get_width());
    var hh = ww / aspect;
    }
else
    {
    //landscape
    var hh = min(base_h, display_get_height());
    var ww = hh * aspect;
    }
surface_resize(application_surface, ww, hh);
display_set_gui_size(base_w, base_h);

