(function() {
    const targetBase = "https://broncodev.pages.dev";
    
    // Captures /path, ?query=params, and #hash
    const newURL = targetBase + 
                   window.location.pathname + 
                   window.location.search + 
                   window.location.hash;

    window.location.replace(newURL);
})();
