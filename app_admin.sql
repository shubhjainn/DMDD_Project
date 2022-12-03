EXEC SUPER_USER.reset_data('Visibility');
EXEC SUPER_USER.reset_data('media_type');
EXEC SUPER_USER.reset_data('post_type');

EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_visibility_proc(1, 'public', '30-DEC-2015 10:10:17.255 AM');
EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_visibility_proc(2, 'private', '30-DEC-2015 01:30:17.150 PM');
EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_visibility_proc(3, 'connections', '30-DEC-2015 05:20:17.250 PM');
commit;

EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_post_type_proc(1, 'timeline_post', -1, '31-DEC-2015 10:20:17.255 PM');
EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_post_type_proc(2, 'story', 1, '31-DEC-2015 11:20:17.255 PM');
commit;


EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_media_type_proc(1, 'jpeg', '01-DEC-2015 01:06:37.433');
EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_media_type_proc(2, 'png', '01-DEC-2015 04:07:37.600');
EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_media_type_proc(3, 'jpg', '01-DEC-2015 06:10:37.513');
EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_media_type_proc(4, 'gif', '02-DEC-2015 09:10:37.450');
EXEC SUPER_USER.ADMIN_ONLY_INSERT_PACK.insert_media_type_proc(5, 'mp4', '31-DEC-2015 10:20:17.255');
commit;