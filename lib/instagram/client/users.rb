module Instagram
  class Client
    # Defines methods related to users
    module Users
      # Returns extended information of a given user
      #
      # @overload user(id=nil, options={})
      #   @param user [Integer] An Instagram user ID
      #   @return [Hashie::Mash] The requested user.
      #   @example Return extended information for @shayne
      #     Instagram.user(20)
      # @format :json
      # @authenticated false unless requesting it from a protected user
      #
      #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
      # @rate_limited true
      # @see TODO:docs url
      def user(*args)
        id = args.first || 'self'
        response = get("users/#{id}")
        response["data"]
      end

      # Returns users that match the given query
      #
      # @format :json
      # @authenticated false
      # @rate_limited true
      # @param query [String] The search query to run against user search.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] :count The number of users to retrieve. Maxiumum of 100 allowed per page.
      # @return [Array]
      # @see TODO:doc url
      # @example Return users that match "Shayne Sweeney"
      #   Instagram.user_search("Shayne Sweeney")
      def user_search(query, options={})
        response = get('users/search', options.merge(:q => query))
        response["data"]
      end

      # Returns a list of users whom a given user follows
      #
      # @overload follows(id=nil, options={})
      #   @param options [Hash] A customizable set of options.
      #   @return [Hashie::Mash]
      #   @example Returns a list of users the authenticated user follows
      #     Instagram.user_follows
      # @overload follows(id=nil, options={})
      #   @param user [Integer] An Instagram user ID.
      #   @param options [Hash] A customizable set of options.
      #   @option options [Integer] :cursor (nil) Breaks the results into pages. Provide values as returned in the response objects's next_cursor attribute to page forward in the list.
      #   @option options [Integer] :count (nil) Limits the number of results returned per page, maximum 150.
      #   @return [Hashie::Mash]
      #   @example Return a list of users @mikeyk follows
      #     Instagram.user_follows(4) # @mikeyk user ID being 4
      # @see TODO:docs url
      # @format :json
      # @authenticated false unless requesting it from a protected user
      #
      #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
      # @rate_limited true
      def user_follows(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        id = args.first || "self"
        response = get("users/#{id}/follows", options)
        response["data"]
      end
    end

    # Returns a list of users whom a given user is followed by
    #
    # @overload user_followed_by(id=nil, options={})
    #   @param options [Hash] A customizable set of options.
    #   @return [Hashie::Mash]
    #   @example Returns a list of users the authenticated user is followed by
    #     Instagram.user_followed_by
    # @overload user_followed_by(id=nil, options={})
    #   @param user [Integer] An Instagram user ID.
    #   @param options [Hash] A customizable set of options.
    #   @option options [Integer] :cursor (nil) Breaks the results into pages. Provide values as returned in the response objects's next_cursor attribute to page forward in the list.
    #   @option options [Integer] :count (nil) Limits the number of results returned per page, maximum 150.
    #   @return [Hashie::Mash]
    #   @example Return a list of users @mikeyk is followed by
    #     Instagram.user_followed_by(4) # @mikeyk user ID being 4
    # @see TODO:docs url
    # @format :json
    # @authenticated false unless requesting it from a protected user
    #
    #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
    # @rate_limited true
    def user_followed_by(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      id = args.first || "self"
      response = get("users/#{id}/followed-by", options)
      response["data"]
    end

    # Returns a list of users whom a given user is followed by
    #
    # @overload user_requested_by()
    #   @param options [Hash] A customizable set of options.
    #   @return [Hashie::Mash]
    #   @example Returns a list of users awaiting approval of a ollow request, for the authenticated user
    #     Instagram.user_requested_by
    # @overload user_requested_by()
    #   @return [Hashie::Mash]
    #   @example Return a list of users who have requested to follow the authenticated user
    #     Instagram.user_requested_by()
    # @see TODO:docs url
    # @format :json
    # @authenticated truei
    # @rate_limited true
    def user_requested_by()
      response = get("users/self/requested-by")
      response["data"]
    end

    # Returns the 20 most recent media items from the currently authorized user's feed.
    #
    # @overload user_media_feed(options={})
    #   @param options [Hash] A customizable set of options.
    #   @option options [Integer] :max_id Returns results with an ID less than (that is, older than) or equal to the specified ID.
    #   @option options [Integer] :count Specifies the number of records to retrieve, per page. Must be less than or equal to 100.
    #   @return [Array]
    #   @example Return the 20 most recent media images that would appear on @shayne's feed
    #     Instagram.user_media_feed() # assuming @shayne is the authorized user
    # @format :json
    # @authenticated true
    # @rate_limited true
    # @see TODO:docs URL
    def user_media_feed(*args)
      options = args.first.is_a?(Hash) ? args.pop : {}
      response = get('users/self/feed', options)
      response["data"]
    end

    # Returns a list of recent media items for a given user
    #
    # @overload user_recent_media(id=nil, options={})
    #   @param options [Hash] A customizable set of options.
    #   @return [Hashie::Mash]
    #   @example Returns a list of recent media items for the currently authenticated user
    #     Instagram.user_recent_media
    # @overload user_recent_media(id=nil, options={})
    #   @param user [Integer] An Instagram user ID.
    #   @param options [Hash] A customizable set of options.
    #   @option options [Integer] :max_id (nil) Returns results with an ID less than (that is, older than) or equal to the specified ID.
    #   @option options [Integer] :count (nil) Limits the number of results returned per page, maximum 150.
    #   @return [Hashie::Mash]
    #   @example Return a list of media items taken by @mikeyk
    #     Instagram.user_recent_media(4) # @mikeyk user ID being 4
    # @see TODO:docs url
    # @format :json
    # @authenticated false unless requesting it from a protected user
    #
    #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
    # @rate_limited true
    def user_recent_media(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      id = args.first || "self"
      response = get("users/#{id}/media/recent", options)
      response["data"]
    end


    def user_relationship(id)
      response = get("users/#{id}/relationship", options)
      response["data"]
    end

    def user_modify_relationship(id, action, options={})
      response = post("users/#{id}/relationship", options.merge(:action => action))
      response["data"]
    end


  end
end
