if (other.state != states.smallpepdash && other.state != states.enemyhitstun && (sprite_index == spr_brick1falling || sprite_index == spr_brick2falling))
{
    instance_destroy(other.id);
    instance_destroy();
    push_notif(13, [object_index]);
}
