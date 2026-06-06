#include <gtk/gtk.h>
#include <gtksourceview/gtksource.h>
#include <stdlib.h>
#include <string.h>

GtkWidget *text_view;
GtkWidget *window;
GtkSourceSearchContext *search_context = NULL;
GtkSourceSearchSettings *search_settings = NULL;
GtkWidget *search_dialog = NULL;
GtkWidget *search_entry = NULL;
PangoFontDescription *font_desc = NULL;
int font_size = 12;

static void open_file(GtkWidget *widget, gpointer data);
static void save_file(GtkWidget *widget, gpointer data);
static void exit_program(GtkWidget *widget, gpointer data);

static void update_font() {
    if (font_desc)
        pango_font_description_free(font_desc);
    char font_str[50];
    snprintf(font_str, sizeof(font_str), "Iosevka %d", font_size);
    font_desc = pango_font_description_from_string(font_str);
    gtk_widget_override_font(text_view, font_desc);
}

static gboolean on_scroll_event(GtkWidget *widget, GdkEventScroll *event, gpointer user_data) {
    if ((event->state & GDK_CONTROL_MASK) != 0) {
        if (event->direction == GDK_SCROLL_UP) {
            font_size++;
            if (font_size > 72) font_size = 72;
            update_font();
        } else if (event->direction == GDK_SCROLL_DOWN) {
            font_size--;
            if (font_size < 6) font_size = 6;
            update_font();
        }
        return TRUE;
    }
    return FALSE;
}

static gboolean on_key_press(GtkWidget *widget, GdkEventKey *event, gpointer user_data) {
    guint key = event->keyval;
    GdkModifierType state = event->state;

    if ((state & GDK_CONTROL_MASK) != 0) {
        switch (key) {
            case GDK_KEY_s:
            case GDK_KEY_S:
                save_file(NULL, NULL);
                return TRUE;
            case GDK_KEY_o:
            case GDK_KEY_O:
                open_file(NULL, NULL);
                return TRUE;
            case GDK_KEY_q:
            case GDK_KEY_Q:
                exit_program(NULL, NULL);
                return TRUE;
            default:
                break;
        }
    }
    return FALSE;
}

static void open_file(GtkWidget *widget, gpointer data) {
    GtkTextBuffer *buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_view));
    GtkWidget *dialog = gtk_file_chooser_dialog_new("Open File",
                              GTK_WINDOW(window),
                              GTK_FILE_CHOOSER_ACTION_OPEN,
                              "_Cancel", GTK_RESPONSE_CANCEL,
                              "_Open", GTK_RESPONSE_ACCEPT,
                              NULL);
    if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT) {
        char *filename = gtk_file_chooser_get_filename(GTK_FILE_CHOOSER(dialog));
        gchar *content = NULL;
        gsize length;
        GError *error = NULL;
        if (g_file_get_contents(filename, &content, &length, &error)) {
            gtk_text_buffer_set_text(buffer, content, length);
            g_free(content);
        } else {
            g_printerr("Error opening file: %s\n", error->message);
            g_error_free(error);
        }
        g_free(filename);
    }
    gtk_widget_destroy(dialog);
}

static void save_file(GtkWidget *widget, gpointer data) {
    GtkTextBuffer *buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_view));
    GtkWidget *dialog = gtk_file_chooser_dialog_new("Save File",
                              GTK_WINDOW(window),
                              GTK_FILE_CHOOSER_ACTION_SAVE,
                              "_Cancel", GTK_RESPONSE_CANCEL,
                              "_Save", GTK_RESPONSE_ACCEPT,
                              NULL);
    if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT) {
        char *filename = gtk_file_chooser_get_filename(GTK_FILE_CHOOSER(dialog));
        GtkTextIter start, end;
        gchar *text;
        gtk_text_buffer_get_start_iter(buffer, &start);
        gtk_text_buffer_get_end_iter(buffer, &end);
        text = gtk_text_buffer_get_text(buffer, &start, &end, FALSE);
        if (!g_file_set_contents(filename, text, -1, NULL)) {
            g_printerr("Error saving file\n");
        }
        g_free(text);
        g_free(filename);
    }
    gtk_widget_destroy(dialog);
}

static void exit_program(GtkWidget *widget, gpointer data) {
    exit(0);
}

static void open_ai_link(GtkWidget *widget, gpointer data) {
    const char *url = "https://www.perplexity.ai/spaces/fuckinspace-Uvxsi9oQTBWsROV4kfUJfQ";
    const char *browser_env = getenv("BROWSER") ? getenv("BROWSER") : "";
    char cmd[512] = {0};
    if (strstr(browser_env, "firefox")) {
        snprintf(cmd, sizeof(cmd), "firefox --new-window %s --width 800 --height 600 &", url);
    } else if (strstr(browser_env, "chrome") || strstr(browser_env, "chromium") || strstr(browser_env, "brave") || strstr(browser_env, "edge") || strstr(browser_env, "opera") || strstr(browser_env, "zen")) {
        snprintf(cmd, sizeof(cmd), "google-chrome --new-window %s --window-size=800,600 &", url);
    } else {
        snprintf(cmd, sizeof(cmd), "xdg-open %s &", url);
    }
    system(cmd);
}

static void clear_search_highlight() {
    if (!search_context)
        return;
    GtkTextBuffer *buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_view));
    GtkTextIter start;
    gtk_text_buffer_get_start_iter(buffer, &start);
    gtk_source_search_settings_set_search_text(search_settings, "");
    gtk_source_search_context_forward(search_context, &start, NULL, NULL);
}

static gboolean on_search_dialog_delete_event(GtkWidget *widget, GdkEvent *event, gpointer user_data) {
    clear_search_highlight();
    gtk_widget_hide(widget);
    return TRUE;
}

static void on_search_text_changed(GtkEntry *entry, gpointer user_data) {
    if (!search_context) return;
    const gchar *text = gtk_entry_get_text(entry);
    gtk_source_search_settings_set_search_text(search_settings, text);
    GtkTextBuffer *buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_view));
    GtkTextIter start;
    gtk_text_buffer_get_start_iter(buffer, &start);
    gboolean found = gtk_source_search_context_forward(search_context, &start, NULL, NULL);
    if (!found) {
        gtk_source_search_context_forward(search_context, NULL, NULL, NULL);
    }
}

static void show_search_dialog(GtkWidget *widget, gpointer user_data) {
    if (search_dialog) {
        gtk_widget_show(search_dialog);
        gtk_window_present(GTK_WINDOW(search_dialog));
        gtk_widget_grab_focus(search_entry);
        return;
    }
    search_dialog = gtk_dialog_new_with_buttons("Find",
                                               GTK_WINDOW(window),
                                               GTK_DIALOG_DESTROY_WITH_PARENT,
                                               NULL);
    g_signal_connect(search_dialog, "delete-event", G_CALLBACK(on_search_dialog_delete_event), NULL);
    GtkWidget *content_area = gtk_dialog_get_content_area(GTK_DIALOG(search_dialog));
    search_entry = gtk_entry_new();
    gtk_entry_set_placeholder_text(GTK_ENTRY(search_entry), "Enter text to find...");
    gtk_container_add(GTK_CONTAINER(content_area), search_entry);
    gtk_widget_show_all(search_dialog);
    if (!search_context) {
        GtkTextBuffer *buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_view));
        search_context = gtk_source_search_context_new(GTK_SOURCE_BUFFER(buffer), NULL);
        search_settings = gtk_source_search_context_get_settings(search_context);
        gtk_source_search_settings_set_wrap_around(search_settings, TRUE);
    }
    g_signal_connect(search_entry, "changed", G_CALLBACK(on_search_text_changed), NULL);
    gtk_widget_grab_focus(search_entry);
}

static void activate(GtkApplication* app, gpointer user_data) {
    window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(window), "CTE Text Editor");
    gtk_window_set_default_size(GTK_WINDOW(window), 800, 600);

    GtkWidget *vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
    GtkWidget *menubar = gtk_menu_bar_new();

    GtkWidget *file_menu = gtk_menu_new();
    GtkWidget *file_mi = gtk_menu_item_new_with_label("File");
    GtkWidget *open_mi = gtk_menu_item_new_with_label("Open");
    GtkWidget *save_mi = gtk_menu_item_new_with_label("Save");
    GtkWidget *exit_mi = gtk_menu_item_new_with_label("Exit");

    gtk_menu_shell_append(GTK_MENU_SHELL(file_menu), open_mi);
    gtk_menu_shell_append(GTK_MENU_SHELL(file_menu), save_mi);
    gtk_menu_shell_append(GTK_MENU_SHELL(file_menu), exit_mi);
    gtk_menu_item_set_submenu(GTK_MENU_ITEM(file_mi), file_menu);
    gtk_menu_shell_append(GTK_MENU_SHELL(menubar), file_mi);

    GtkWidget *find_mi = gtk_menu_item_new_with_label("Find");
    gtk_menu_shell_append(GTK_MENU_SHELL(menubar), find_mi);

    GtkWidget *ai_mi = gtk_menu_item_new_with_label("AI");
    gtk_menu_shell_append(GTK_MENU_SHELL(menubar), ai_mi);

    g_signal_connect(open_mi, "activate", G_CALLBACK(open_file), NULL);
    g_signal_connect(save_mi, "activate", G_CALLBACK(save_file), NULL);
    g_signal_connect(exit_mi, "activate", G_CALLBACK(exit_program), NULL);
    g_signal_connect(ai_mi, "activate", G_CALLBACK(open_ai_link), NULL);
    g_signal_connect(find_mi, "activate", G_CALLBACK(show_search_dialog), NULL);
    g_signal_connect(window, "destroy", G_CALLBACK(exit_program), NULL);

    gtk_box_pack_start(GTK_BOX(vbox), menubar, FALSE, FALSE, 0);

    text_view = gtk_source_view_new();

    gtk_text_view_set_wrap_mode(GTK_TEXT_VIEW(text_view), GTK_WRAP_WORD_CHAR);
    gtk_text_view_set_left_margin(GTK_TEXT_VIEW(text_view), 10);
    gtk_text_view_set_right_margin(GTK_TEXT_VIEW(text_view), 10);
    gtk_text_view_set_top_margin(GTK_TEXT_VIEW(text_view), 10);
    gtk_text_view_set_bottom_margin(GTK_TEXT_VIEW(text_view), 10);

    update_font();

    GtkSourceBuffer *source_buffer = GTK_SOURCE_BUFFER(gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_view)));
    GtkSourceLanguageManager *lm = gtk_source_language_manager_get_default();
    GtkSourceLanguage *language = gtk_source_language_manager_get_language(lm, "c");
    gtk_source_buffer_set_language(source_buffer, language);
    GtkSourceStyleSchemeManager *sm = gtk_source_style_scheme_manager_get_default();
    GtkSourceStyleScheme *scheme = gtk_source_style_scheme_manager_get_scheme(sm, "classic");
    gtk_source_buffer_set_style_scheme(source_buffer, scheme);

    GtkWidget *scrollwin = gtk_scrolled_window_new(NULL, NULL);
    gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrollwin),
                                   GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
    gtk_container_add(GTK_CONTAINER(scrollwin), text_view);
    gtk_box_pack_start(GTK_BOX(vbox), scrollwin, TRUE, TRUE, 0);

    gtk_container_add(GTK_CONTAINER(window), vbox);

    g_signal_connect(text_view, "scroll-event", G_CALLBACK(on_scroll_event), NULL);

    g_signal_connect(text_view, "key-press-event", G_CALLBACK(on_key_press), NULL);

    gtk_widget_show_all(window);
}

int main(int argc, char **argv) {
    GtkApplication *app;
    int status;
    app = gtk_application_new("org.example.CTETextEditor", G_APPLICATION_DEFAULT_FLAGS);
    g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);
    status = g_application_run(G_APPLICATION(app), argc, argv);
    g_object_unref(app);
    if (font_desc)
        pango_font_description_free(font_desc);
    return status;
}
